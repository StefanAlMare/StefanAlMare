// OCLP7 D97AEX -- bounded live D5CE text provenance reader.
//
// This helper is intentionally macOS/x86_64-only.  It watches naturally
// occurring MTLCompilerService instances and requests only a TASK_FLAVOR_READ
// port through Apple's private task_read_for_pid API.  It never launches,
// stops, writes to, protects, allocates in, or otherwise controls a target.

#if !defined(__APPLE__) || !defined(__x86_64__)
#error "D97AEX must be compiled for macOS x86_64"
#endif

#include <bsm/libbsm.h>
#include <libproc.h>
#include <mach/mach.h>
#include <mach/mach_vm.h>
#include <mach/task_info.h>
#include <mach-o/loader.h>
#include <sys/proc_info.h>
#include <sys/stat.h>
#include <unistd.h>

#include <algorithm>
#include <array>
#include <cerrno>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <iterator>
#include <limits>
#include <map>
#include <sstream>
#include <stdexcept>
#include <string>
#include <thread>
#include <tuple>
#include <utility>
#include <vector>

// task_read_for_pid is shipped by libSystem but hidden behind PRIVATE in the
// public XNU header.  Keep the published ABI declaration local and exact.
extern "C" int task_read_for_pid(unsigned int target_tport, int pid,
                                  unsigned int* task_port);

namespace {

constexpr char kServicePath[] =
    "/System/Library/Frameworks/Metal.framework/Versions/A/XPCServices/"
    "MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService";
constexpr char kTargetPath[] =
    "/System/Library/PrivateFrameworks/MTLCompiler.framework/Versions/32023/"
    "MTLCompiler";
constexpr char kTargetPathSuffix[] =
    "/MTLCompiler.framework/Versions/32023/MTLCompiler";
constexpr char kExpectedServiceUuid[] =
    "3716D20F-B990-3906-B3E5-44E88AE63AF8";
constexpr char kExpectedTargetUuid[] =
    "D5CE0008-587C-3861-971A-4BAEFB7B9C5B";
constexpr char kExpectedServiceSha256[] =
    "a8716ffd75acab7ca2dd11b87861895f28fed386d098ad25280aba022f5b8b43";
constexpr char kExpectedVisibleTargetSha256[] =
    "524a16a716a4da8c26caf576dcf1fff7ed454e332cbfff81225578c934c8a755";
constexpr int64_t kExpectedTargetFileSize = 1636864;

constexpr uint32_t kExpectedCpuType = 0x01000007U;
constexpr uint32_t kExpectedCpuSubtype = 3U;
constexpr uint32_t kExpectedFileType = 6U;
constexpr uint32_t kExpectedNcmds = 25U;
constexpr uint32_t kExpectedSizeofcmds = 0xED8U;
constexpr uint64_t kExpectedTextVmaddr = 0x7FFB1622A000ULL;
constexpr uint64_t kExpectedTextVmsize = 0xC9000ULL;
constexpr uint64_t kExpectedTextFileoff = 0ULL;
constexpr uint64_t kExpectedTextFilesize = 0xC9000ULL;
constexpr size_t kExpectedHeaderBytes = sizeof(mach_header_64) +
                                        kExpectedSizeofcmds;

constexpr unsigned kDefaultDurationSeconds = 120;
constexpr unsigned kDefaultIntervalMilliseconds = 25;
constexpr unsigned kDefaultMinimumComplete = 3;
constexpr unsigned kMaximumDurationSeconds = 600;
constexpr unsigned kMinimumIntervalMilliseconds = 5;
constexpr unsigned kMaximumIntervalMilliseconds = 1000;
constexpr unsigned kMaximumMinimumComplete = 100;
constexpr size_t kMaximumRemotePath = 4096;
constexpr uint32_t kMaximumImageCount = 4096;

#ifndef PROC_PIDUNIQIDENTIFIERINFO
#define PROC_PIDUNIQIDENTIFIERINFO 17
#endif

// Current XNU API layout.  A local name avoids depending on whether a given
// public SDK exposes the otherwise-private structure declaration.
struct ProcUniqIdentifierInfo {
  uint8_t p_uuid[16];
  uint64_t p_uniqueid;
  uint64_t p_puniqueid;
  int32_t p_idversion;
  int32_t p_orig_ppidversion;
  uint64_t p_reserve2;
  uint64_t p_reserve3;
};
static_assert(sizeof(ProcUniqIdentifierInfo) == 56,
              "PROC_PIDUNIQIDENTIFIERINFO ABI drift");

enum class Role {
  kD97adSite,
  kStub,
  kRetained,
  kLateInvariant,
  kFarInvariant,
};

struct WindowSpec {
  const char* name;
  uint64_t file_offset;
  size_t length;
  const char* pre_hex;
  const char* post_hex;
  Role role;
};

constexpr std::array<WindowSpec, 31> kWindows = {{
    {"CANDIDATE_110", 0x9D6BD, 9, "8b8d10feffff83f941",
     "6a6e5fe9bb38f6ff90", Role::kD97adSite},
    {"BUFFER_111", 0x9D3CC, 12, "488d3599640200b91e000000",
     "6a6f5fe9ac3bf6ff90909090", Role::kD97adSite},
    {"SAMPLER_112", 0x9D40B, 10, "488d359764020083fa10",
     "6a705fe96d3bf6ff9090", Role::kD97adSite},
    {"NESTED_113", 0x9D514, 9, "488d35cc63020031c0",
     "6a715fe9643af6ff90", Role::kD97adSite},
    {"EARLY_RETURN_114", 0x9D1EB, 10, "4489f04881c488030000",
     "6a725fe98d3df6ff9090", Role::kD97adSite},
    {"UNWIND_114", 0x9D7FE, 12, "488dbd20feffffe8c45c0100",
     "6a725fe97a37f6ff90909090", Role::kD97adSite},

    {"SHARED_EXIT_STUB", 0xF80, 33,
     "000000000000000000000000000000000000000000000000000000000000000000",
     "b8010000020f050f0b000000000000000000000000000000000000000000000000",
     Role::kStub},

    {"D34_PROTECTED_CAVE", 0xEF8, 7, "00000000000000",
     "4889f8488937c3", Role::kRetained},
    {"AIR00", 0x9A933, 8, "488b433049894628", "49c7462800000000",
     Role::kRetained},
    {"P7_PORT_01", 0x9A93B, 6, "8b8388000000", "8b83a8000000",
     Role::kRetained},
    {"P7_PORT_02", 0x9A946, 6, "8b8b8c000000", "8b8bac000000",
     Role::kRetained},
    {"P6_PORT_01", 0x9F53A, 7, "f680c400000001", "f680e400000001",
     Role::kRetained},
    {"P6_PORT_02", 0x9F5B0, 7, "f680c400000001", "f680e400000001",
     Role::kRetained},
    {"P6_PORT_03", 0x9F63F, 7, "f680c400000001", "f680e400000001",
     Role::kRetained},
    {"P6_PORT_04", 0x9F65E, 7, "f680c400000002", "f680e400000002",
     Role::kRetained},
    {"P6_PORT_05", 0x9E95D, 7, "f683c400000001", "f683e400000001",
     Role::kRetained},
    {"P6_PORT_06", 0x9E97C, 7, "f683c400000002", "f683e400000002",
     Role::kRetained},
    {"P6_PORT_07", 0x9E9CF, 7, "f683c400000004", "f683e400000004",
     Role::kRetained},
    {"P6_PORT_08", 0x9E985, 6, "8b93c8000000", "8b93e8000000",
     Role::kRetained},
    {"P6_PORT_09", 0x9E9AC, 6, "8b93c8000000", "8b93e8000000",
     Role::kRetained},
    {"P6_PORT_10", 0x9E8EF, 6, "8bb3cc000000", "8bb3ec000000",
     Role::kRetained},
    {"P6_PORT_11", 0x9E757, 6, "8bb3dc000000", "8bb31c010000",
     Role::kRetained},
    {"P6_PORT_12", 0x9E74E, 7, "83bee000000000", "83be2001000000",
     Role::kRetained},

    {"LATE_BUFFERS_XREF", 0x9D6C8, 16,
     "488d357a6202004531f6488bbd18feff",
     "488d357a6202004531f6488bbd18feff", Role::kLateInvariant},
    {"LATE_SAMPLERS_XREF", 0x9D6EE, 16,
     "488d35946202004531f6488bbd18feff",
     "488d35946202004531f6488bbd18feff", Role::kLateInvariant},
    {"LATE_TEXTURES_XREF", 0x9D712, 16,
     "488d35b16202004531f6488bbd18feff",
     "488d35b16202004531f6488bbd18feff", Role::kLateInvariant},
    {"LATE_CONSTBUF_XREF", 0x9D73A, 16,
     "488d35ca6202004531f6488bbd18feff",
     "488d35ca6202004531f6488bbd18feff", Role::kLateInvariant},
    {"LATE_INTERP_XREF", 0x9D75D, 16,
     "488d35f86202004531f6488bbd18feff",
     "488d35f86202004531f6488bbd18feff", Role::kLateInvariant},
    {"COMMON_FORMATTER_CALL", 0x9D775, 16,
     "e8fa93f8ffe958faffff8b9d14feffff",
     "e8fa93f8ffe958faffff8b9d14feffff", Role::kLateInvariant},

    {"SENDER_PC_5_OF_33", 0x9FFEE, 16,
     "e8e13d010048898520ffffff48c78518",
     "e8e13d010048898520ffffff48c78518", Role::kFarInvariant},
    {"SENDER_PC_28_OF_33", 0xA5F81, 16,
     "e84ede00004989c44c8db560ffffff4c",
     "e84ede00004989c44c8db560ffffff4c", Role::kFarInvariant},
}};

struct Options {
  unsigned duration_seconds = kDefaultDurationSeconds;
  unsigned interval_milliseconds = kDefaultIntervalMilliseconds;
  unsigned minimum_complete = kDefaultMinimumComplete;
  bool self_test = false;
};

struct MachoIdentity {
  mach_header_64 header{};
  segment_command_64 text{};
  std::array<uint8_t, 16> uuid{};
};

struct RemoteDyldAllImageInfosPrefix {
  uint32_t version;
  uint32_t info_array_count;
  uint64_t info_array;
};
static_assert(sizeof(RemoteDyldAllImageInfosPrefix) == 16,
              "remote dyld prefix ABI drift");

struct RemoteDyldImageInfo {
  uint64_t image_load_address;
  uint64_t image_file_path;
  uint64_t image_file_mod_date;
};
static_assert(sizeof(RemoteDyldImageInfo) == 24,
              "remote dyld image-info ABI drift");

struct DyldImageRecord {
  uint64_t header_address = 0;
  std::string path;
};

struct ProcIdentity {
  pid_t pid = -1;
  ProcUniqIdentifierInfo uniq{};
  proc_bsdinfo bsd{};
  std::string path;
};

struct IdentityKey {
  uint64_t unique_id = 0;
  int32_t id_version = 0;
  uint64_t start_seconds = 0;
  uint64_t start_microseconds = 0;

  bool operator<(const IdentityKey& other) const {
    return std::tie(unique_id, id_version, start_seconds, start_microseconds) <
           std::tie(other.unique_id, other.id_version, other.start_seconds,
                    other.start_microseconds);
  }
};

struct AuditIdentity {
  audit_token_t token{};
  pid_t pid = -1;
  int pid_version = -1;
  uid_t effective_uid = static_cast<uid_t>(-1);
  uid_t real_uid = static_cast<uid_t>(-1);
};

struct RegionIdentity {
  uint64_t address = 0;
  uint64_t size = 0;
  uint64_t file_offset = 0;
  uint32_t protection = 0;
  uint32_t max_protection = 0;
  uint32_t inheritance = 0;
  uint32_t flags = 0;
  uint32_t user_tag = 0;
  uint32_t share_mode = 0;
  uint32_t object_id = 0;
  uint32_t vnode_device = 0;
  uint64_t vnode_inode = 0;
  int64_t vnode_size = 0;
  std::string path;
};

struct FileIdentity {
  uint64_t device = 0;
  uint64_t inode = 0;
  int64_t size = 0;
  int64_t mtime_seconds = 0;
  int64_t mtime_nanoseconds = 0;
};

enum class CaptureKind {
  kNotReady,
  kRaceIncomplete,
  kUuidNegative,
  kCompleteProvenanceMatch,
  kCompleteProvenanceMismatch,
  kFatal,
};

struct CaptureResult {
  CaptureKind kind = CaptureKind::kFatal;
  std::string reason;
};

struct EvidenceFlags {
  bool patch_windows_match = false;
  bool invariant_fingerprint_match = false;
  bool all_31_provenance_match = false;
};

EvidenceFlags aggregate_evidence(size_t d97_post, size_t stub_post,
                                 size_t retained_post, size_t late_match,
                                 size_t far_match,
                                 size_t expected_window_count) {
  EvidenceFlags result{};
  result.patch_windows_match =
      d97_post == 6 && stub_post == 1 && retained_post == 16;
  result.invariant_fingerprint_match =
      late_match == 6 && far_match == 2;
  result.all_31_provenance_match =
      expected_window_count == kWindows.size() && result.patch_windows_match &&
      result.invariant_fingerprint_match;
  return result;
}

struct InstanceState {
  pid_t last_pid = -1;
  bool terminal = false;
  CaptureKind terminal_kind = CaptureKind::kNotReady;
  unsigned attempts = 0;
};

class TaskPort {
 public:
  explicit TaskPort(mach_port_t port) : port_(port) {}
  TaskPort(const TaskPort&) = delete;
  TaskPort& operator=(const TaskPort&) = delete;
  ~TaskPort() { close(); }

  mach_port_t get() const { return port_; }

  bool close() {
    if (port_ == MACH_PORT_NULL) {
      return true;
    }
    const kern_return_t kr = mach_port_deallocate(mach_task_self(), port_);
    if (kr == KERN_SUCCESS) {
      port_ = MACH_PORT_NULL;
    }
    return kr == KERN_SUCCESS;
  }

 private:
  mach_port_t port_ = MACH_PORT_NULL;
};

[[noreturn]] void fail(const std::string& message) {
  throw std::runtime_error(message);
}

std::string hex_bytes(const uint8_t* bytes, size_t length) {
  std::ostringstream out;
  out << std::hex << std::setfill('0');
  for (size_t i = 0; i < length; ++i) {
    out << std::setw(2) << static_cast<unsigned>(bytes[i]);
  }
  return out.str();
}

std::string hex_bytes(const std::vector<uint8_t>& bytes) {
  return hex_bytes(bytes.data(), bytes.size());
}

int hex_nibble(char c) {
  if (c >= '0' && c <= '9') {
    return c - '0';
  }
  if (c >= 'a' && c <= 'f') {
    return c - 'a' + 10;
  }
  if (c >= 'A' && c <= 'F') {
    return c - 'A' + 10;
  }
  return -1;
}

std::vector<uint8_t> decode_hex(const char* text) {
  const size_t length = std::strlen(text);
  if ((length & 1U) != 0U) {
    fail("HEX_ODD_LENGTH");
  }
  std::vector<uint8_t> result(length / 2U);
  for (size_t i = 0; i < result.size(); ++i) {
    const int high = hex_nibble(text[i * 2U]);
    const int low = hex_nibble(text[i * 2U + 1U]);
    if (high < 0 || low < 0) {
      fail("HEX_INVALID_DIGIT");
    }
    result[i] = static_cast<uint8_t>((high << 4) | low);
  }
  return result;
}

std::string uuid_string(const uint8_t* bytes) {
  static constexpr std::array<size_t, 4> kHyphenBefore = {{4, 6, 8, 10}};
  std::ostringstream out;
  out << std::uppercase << std::hex << std::setfill('0');
  for (size_t i = 0; i < 16; ++i) {
    if (std::find(kHyphenBefore.begin(), kHyphenBefore.end(), i) !=
        kHyphenBefore.end()) {
      out << '-';
    }
    out << std::setw(2) << static_cast<unsigned>(bytes[i]);
  }
  return out.str();
}

const char* role_name(Role role) {
  switch (role) {
    case Role::kD97adSite:
      return "D97AD_SITE";
    case Role::kStub:
      return "STUB";
    case Role::kRetained:
      return "RETAINED";
    case Role::kLateInvariant:
      return "LATE_INVARIANT";
    case Role::kFarInvariant:
      return "FAR_INVARIANT";
  }
  return "INVALID";
}

bool is_invariant(Role role) {
  return role == Role::kLateInvariant || role == Role::kFarInvariant;
}

std::string classify_window(const WindowSpec& spec,
                            const std::vector<uint8_t>& actual) {
  const std::vector<uint8_t> pre = decode_hex(spec.pre_hex);
  const std::vector<uint8_t> post = decode_hex(spec.post_hex);
  if (is_invariant(spec.role)) {
    return actual == post ? "INVARIANT_MATCH" : "OTHER";
  }
  if (actual == pre) {
    return "PRE";
  }
  if (actual == post) {
    return "POST";
  }
  return "OTHER";
}

void validate_manifest() {
  size_t total_bytes = 0;
  size_t d97_count = 0;
  size_t d97_bytes = 0;
  size_t stub_count = 0;
  size_t stub_bytes = 0;
  size_t retained_count = 0;
  size_t retained_bytes = 0;
  size_t late_count = 0;
  size_t late_bytes = 0;
  size_t far_count = 0;
  size_t far_bytes = 0;

  for (size_t i = 0; i < kWindows.size(); ++i) {
    const WindowSpec& spec = kWindows[i];
    const std::vector<uint8_t> pre = decode_hex(spec.pre_hex);
    const std::vector<uint8_t> post = decode_hex(spec.post_hex);
    if (pre.size() != spec.length || post.size() != spec.length) {
      fail(std::string("MANIFEST_LENGTH_MISMATCH:") + spec.name);
    }
    if (is_invariant(spec.role) && pre != post) {
      fail(std::string("MANIFEST_INVARIANT_PRE_POST_DIFFER:") + spec.name);
    }
    if (spec.file_offset > kExpectedTextFilesize ||
        spec.length > kExpectedTextFilesize - spec.file_offset) {
      fail(std::string("MANIFEST_OUTSIDE_TEXT:") + spec.name);
    }
    for (size_t j = i + 1; j < kWindows.size(); ++j) {
      const WindowSpec& other = kWindows[j];
      const uint64_t a_end = spec.file_offset + spec.length;
      const uint64_t b_end = other.file_offset + other.length;
      if (spec.file_offset < b_end && other.file_offset < a_end) {
        fail(std::string("MANIFEST_OVERLAP:") + spec.name + ":" +
             other.name);
      }
    }
    total_bytes += spec.length;
    switch (spec.role) {
      case Role::kD97adSite:
        ++d97_count;
        d97_bytes += spec.length;
        break;
      case Role::kStub:
        ++stub_count;
        stub_bytes += spec.length;
        break;
      case Role::kRetained:
        ++retained_count;
        retained_bytes += spec.length;
        break;
      case Role::kLateInvariant:
        ++late_count;
        late_bytes += spec.length;
        break;
      case Role::kFarInvariant:
        ++far_count;
        far_bytes += spec.length;
        break;
    }
  }

  if (d97_count != 6 || d97_bytes != 62 || stub_count != 1 ||
      stub_bytes != 33 || retained_count != 16 || retained_bytes != 107 ||
      late_count != 6 || late_bytes != 96 || far_count != 2 ||
      far_bytes != 32 || total_bytes != 330) {
    fail("MANIFEST_CARDINALITY_OR_TOTAL_MISMATCH");
  }
}

template <typename T>
T load_object(const std::vector<uint8_t>& bytes, size_t offset) {
  if (offset > bytes.size() || sizeof(T) > bytes.size() - offset) {
    fail("MACHO_OBJECT_RANGE_OOB");
  }
  T value{};
  std::memcpy(&value, bytes.data() + offset, sizeof(value));
  return value;
}

MachoIdentity parse_macho(const std::vector<uint8_t>& bytes) {
  if (bytes.size() < sizeof(mach_header_64)) {
    fail("MACHO_HEADER_SHORT");
  }
  MachoIdentity result{};
  result.header = load_object<mach_header_64>(bytes, 0);
  if (result.header.magic != MH_MAGIC_64) {
    fail("MACHO_MAGIC_NOT_MH_MAGIC_64");
  }
  const size_t command_end = sizeof(mach_header_64) +
                             static_cast<size_t>(result.header.sizeofcmds);
  if (command_end != bytes.size()) {
    fail("MACHO_LOAD_COMMAND_BUFFER_SIZE_MISMATCH");
  }

  size_t cursor = sizeof(mach_header_64);
  unsigned text_count = 0;
  unsigned uuid_count = 0;
  for (uint32_t index = 0; index < result.header.ncmds; ++index) {
    const load_command command = load_object<load_command>(bytes, cursor);
    if (command.cmdsize < sizeof(load_command) ||
        (command.cmdsize & 7U) != 0U || cursor > command_end ||
        command.cmdsize > command_end - cursor) {
      fail("MACHO_LOAD_COMMAND_INVALID");
    }
    if (command.cmd == LC_SEGMENT_64) {
      if (command.cmdsize < sizeof(segment_command_64)) {
        fail("MACHO_SEGMENT_COMMAND_SHORT");
      }
      const segment_command_64 segment =
          load_object<segment_command_64>(bytes, cursor);
      const bool is_text =
          std::memcmp(segment.segname, "__TEXT", 6) == 0 &&
          segment.segname[6] == '\0';
      if (is_text) {
        ++text_count;
        result.text = segment;
      }
    } else if (command.cmd == LC_UUID) {
      if (command.cmdsize != sizeof(uuid_command)) {
        fail("MACHO_UUID_COMMAND_SIZE_INVALID");
      }
      const uuid_command uuid = load_object<uuid_command>(bytes, cursor);
      ++uuid_count;
      std::copy(std::begin(uuid.uuid), std::end(uuid.uuid),
                result.uuid.begin());
    }
    cursor += command.cmdsize;
  }
  if (cursor != command_end) {
    fail("MACHO_LOAD_COMMANDS_DO_NOT_EXHAUST_SIZE");
  }
  if (text_count != 1) {
    fail("MACHO_TEXT_SEGMENT_CARDINALITY_NOT_ONE");
  }
  if (uuid_count != 1) {
    fail("MACHO_UUID_CARDINALITY_NOT_ONE");
  }
  return result;
}

void validate_expected_topology(const MachoIdentity& macho) {
  if (static_cast<uint32_t>(macho.header.cputype) != kExpectedCpuType ||
      static_cast<uint32_t>(macho.header.cpusubtype) !=
          kExpectedCpuSubtype ||
      macho.header.filetype != kExpectedFileType ||
      macho.header.ncmds != kExpectedNcmds ||
      macho.header.sizeofcmds != kExpectedSizeofcmds) {
    fail("D5CE_MACHO_HEADER_TOPOLOGY_MISMATCH");
  }
  if (macho.text.vmaddr != kExpectedTextVmaddr ||
      macho.text.vmsize != kExpectedTextVmsize ||
      macho.text.fileoff != kExpectedTextFileoff ||
      macho.text.filesize != kExpectedTextFilesize) {
    fail("D5CE_TEXT_TOPOLOGY_MISMATCH");
  }
  const uint32_t text_protection =
      static_cast<uint32_t>(macho.text.initprot) &
      static_cast<uint32_t>(VM_PROT_READ | VM_PROT_WRITE | VM_PROT_EXECUTE);
  if (text_protection !=
      static_cast<uint32_t>(VM_PROT_READ | VM_PROT_EXECUTE)) {
    fail("D5CE_TEXT_INITPROT_NOT_RX");
  }
}

uint64_t runtime_address_for_file_offset(const MachoIdentity& macho,
                                         uint64_t remote_header,
                                         uint64_t file_offset,
                                         size_t length) {
  if (file_offset < macho.text.fileoff ||
      file_offset > macho.text.fileoff + macho.text.filesize ||
      length > macho.text.fileoff + macho.text.filesize - file_offset) {
    fail("WINDOW_NOT_CONTAINED_IN_TEXT_FILE_RANGE");
  }
  const __int128 slide = static_cast<__int128>(remote_header) -
                         static_cast<__int128>(macho.text.vmaddr);
  const __int128 address =
      slide + static_cast<__int128>(macho.text.vmaddr) +
      static_cast<__int128>(file_offset - macho.text.fileoff);
  if (address < 0 ||
      address > static_cast<__int128>(std::numeric_limits<uint64_t>::max()) ||
      static_cast<__int128>(length) >
          static_cast<__int128>(std::numeric_limits<uint64_t>::max()) -
              address) {
    fail("WINDOW_RUNTIME_ADDRESS_OVERFLOW");
  }
  return static_cast<uint64_t>(address);
}

std::vector<uint8_t> read_once(mach_port_t task, uint64_t address,
                               size_t length) {
  if (length == 0 || address > std::numeric_limits<uint64_t>::max() - length) {
    fail("REMOTE_READ_RANGE_INVALID");
  }
  std::vector<uint8_t> bytes(length);
  mach_vm_size_t output_size = 0;
  const kern_return_t kr = mach_vm_read_overwrite(
      task, static_cast<mach_vm_address_t>(address),
      static_cast<mach_vm_size_t>(length),
      reinterpret_cast<mach_vm_address_t>(bytes.data()), &output_size);
  if (kr != KERN_SUCCESS) {
    fail("REMOTE_READ_KERN_FAILURE:" + std::to_string(kr));
  }
  if (output_size != length) {
    fail("REMOTE_READ_SHORT:" + std::to_string(output_size) + ":" +
         std::to_string(length));
  }
  return bytes;
}

std::vector<uint8_t> stable_read(mach_port_t task, uint64_t address,
                                 size_t length) {
  const std::vector<uint8_t> first = read_once(task, address, length);
  const std::vector<uint8_t> second = read_once(task, address, length);
  if (first != second) {
    fail("REMOTE_DOUBLE_READ_UNSTABLE");
  }
  return first;
}

std::string stable_remote_string(mach_port_t task, uint64_t address) {
  if (address == 0) {
    fail("REMOTE_PATH_POINTER_NULL");
  }
  std::string result;
  result.reserve(128);
  while (result.size() < kMaximumRemotePath) {
    const uint64_t current = address + result.size();
    if (current < address) {
      fail("REMOTE_PATH_ADDRESS_OVERFLOW");
    }
    const size_t page_remaining =
        4096U - static_cast<size_t>(current & 0xFFFULL);
    const size_t chunk =
        std::min({static_cast<size_t>(256), page_remaining,
                  kMaximumRemotePath - result.size()});
    const std::vector<uint8_t> bytes = stable_read(task, current, chunk);
    const auto nul = std::find(bytes.begin(), bytes.end(), 0);
    result.append(reinterpret_cast<const char*>(bytes.data()),
                  static_cast<size_t>(nul - bytes.begin()));
    if (nul != bytes.end()) {
      return result;
    }
  }
  fail("REMOTE_PATH_NOT_NUL_TERMINATED");
}

task_dyld_info_data_t stable_task_dyld_info(mach_port_t task) {
  task_dyld_info_data_t first{};
  task_dyld_info_data_t second{};
  mach_msg_type_number_t first_count = TASK_DYLD_INFO_COUNT;
  mach_msg_type_number_t second_count = TASK_DYLD_INFO_COUNT;
  kern_return_t kr = task_info(task, TASK_DYLD_INFO,
                               reinterpret_cast<task_info_t>(&first),
                               &first_count);
  if (kr != KERN_SUCCESS || first_count != TASK_DYLD_INFO_COUNT) {
    fail("TASK_DYLD_INFO_FIRST_FAILED:" + std::to_string(kr));
  }
  kr = task_info(task, TASK_DYLD_INFO,
                 reinterpret_cast<task_info_t>(&second), &second_count);
  if (kr != KERN_SUCCESS || second_count != TASK_DYLD_INFO_COUNT) {
    fail("TASK_DYLD_INFO_SECOND_FAILED:" + std::to_string(kr));
  }
  if (first.all_image_info_addr != second.all_image_info_addr ||
      first.all_image_info_size != second.all_image_info_size ||
      first.all_image_info_format != second.all_image_info_format) {
    fail("TASK_DYLD_INFO_UNSTABLE");
  }
  if (first.all_image_info_addr == 0 ||
      first.all_image_info_size < sizeof(RemoteDyldAllImageInfosPrefix)) {
    fail("TASK_DYLD_INFO_RANGE_INVALID");
  }
#ifdef TASK_DYLD_ALL_IMAGE_INFO_64
  if (first.all_image_info_format != TASK_DYLD_ALL_IMAGE_INFO_64) {
#else
  if (first.all_image_info_format != 1) {
#endif
    fail("TASK_DYLD_INFO_NOT_64_BIT");
  }
  return first;
}

std::vector<DyldImageRecord> stable_dyld_images(mach_port_t task) {
  const task_dyld_info_data_t task_dyld = stable_task_dyld_info(task);
  const std::vector<uint8_t> prefix_bytes = stable_read(
      task, task_dyld.all_image_info_addr,
      sizeof(RemoteDyldAllImageInfosPrefix));
  RemoteDyldAllImageInfosPrefix prefix{};
  std::memcpy(&prefix, prefix_bytes.data(), sizeof(prefix));
  if (prefix.version == 0 || prefix.info_array_count > kMaximumImageCount) {
    fail("DYLD_ALL_IMAGE_INFOS_PREFIX_INVALID");
  }
  if (prefix.info_array_count != 0 && prefix.info_array == 0) {
    fail("DYLD_IMAGE_ARRAY_POINTER_NULL");
  }
  if (prefix.info_array_count == 0) {
    return {};
  }
  const size_t array_size =
      static_cast<size_t>(prefix.info_array_count) * sizeof(RemoteDyldImageInfo);
  const std::vector<uint8_t> array_bytes =
      stable_read(task, prefix.info_array, array_size);
  std::vector<DyldImageRecord> records;
  records.reserve(prefix.info_array_count);
  for (uint32_t i = 0; i < prefix.info_array_count; ++i) {
    RemoteDyldImageInfo remote{};
    std::memcpy(&remote, array_bytes.data() +
                             static_cast<size_t>(i) * sizeof(remote),
                sizeof(remote));
    if (remote.image_load_address == 0 || remote.image_file_path == 0) {
      fail("DYLD_IMAGE_RECORD_NULL_FIELD");
    }
    records.push_back(
        {remote.image_load_address,
         stable_remote_string(task, remote.image_file_path)});
  }
  return records;
}

bool find_exact_target_record(const std::vector<DyldImageRecord>& records,
                              DyldImageRecord* target) {
  size_t exact_count = 0;
  size_t nonexact_32023_count = 0;
  for (const DyldImageRecord& record : records) {
    if (record.path == kTargetPath) {
      ++exact_count;
      *target = record;
    } else if (record.path.find(kTargetPathSuffix) != std::string::npos) {
      ++nonexact_32023_count;
    }
  }
  if (nonexact_32023_count != 0) {
    fail("DYLD_32023_PATH_PRESENT_BUT_NOT_EXACT");
  }
  if (exact_count > 1) {
    fail("DYLD_EXACT_32023_LOGICAL_PATH_CARDINALITY_GT_ONE");
  }
  return exact_count == 1;
}

std::vector<uint8_t> stable_remote_macho(mach_port_t task,
                                         uint64_t header_address) {
  const std::vector<uint8_t> header_bytes =
      stable_read(task, header_address, sizeof(mach_header_64));
  mach_header_64 header{};
  std::memcpy(&header, header_bytes.data(), sizeof(header));
  if (header.magic != MH_MAGIC_64) {
    fail("REMOTE_MACHO_MAGIC_NOT_MH_MAGIC_64");
  }
  if (header.sizeofcmds > 1024U * 1024U) {
    fail("REMOTE_MACHO_SIZEOFCMDS_INVALID");
  }
  const size_t total = sizeof(mach_header_64) + header.sizeofcmds;
  const std::vector<uint8_t> full = stable_read(task, header_address, total);
  if (!std::equal(header_bytes.begin(), header_bytes.end(), full.begin())) {
    fail("REMOTE_MACHO_HEADER_CHANGED_BETWEEN_READS");
  }
  return full;
}

std::string local_process_path(pid_t pid) {
  std::array<char, PROC_PIDPATHINFO_MAXSIZE> path{};
  const int result = proc_pidpath(pid, path.data(),
                                  static_cast<uint32_t>(path.size()));
  if (result <= 0) {
    fail("PROC_PIDPATH_FAILED:" + std::to_string(errno));
  }
  if (std::find(path.begin(), path.end(), '\0') == path.end()) {
    fail("PROC_PIDPATH_NOT_NUL_TERMINATED");
  }
  return std::string(path.data());
}

ProcIdentity query_process_identity(pid_t pid) {
  ProcIdentity identity{};
  identity.pid = pid;
  const int uniq_result = proc_pidinfo(
      pid, PROC_PIDUNIQIDENTIFIERINFO, 0, &identity.uniq,
      static_cast<int>(sizeof(identity.uniq)));
  if (uniq_result != static_cast<int>(sizeof(identity.uniq))) {
    fail("PROC_PIDUNIQIDENTIFIERINFO_FAILED_OR_SHORT:" +
         std::to_string(uniq_result) + ":" + std::to_string(errno));
  }
  const int bsd_result =
      proc_pidinfo(pid, PROC_PIDTBSDINFO, 0, &identity.bsd,
                   static_cast<int>(sizeof(identity.bsd)));
  if (bsd_result != static_cast<int>(sizeof(identity.bsd))) {
    fail("PROC_PIDTBSDINFO_FAILED_OR_SHORT:" + std::to_string(bsd_result) +
         ":" + std::to_string(errno));
  }
  identity.path = local_process_path(pid);
  if (identity.path != kServicePath) {
    fail("SERVICE_PATH_CHANGED_OR_NOT_EXACT");
  }
  if (identity.bsd.pbi_pid != static_cast<uint32_t>(pid) ||
      identity.uniq.p_uniqueid == 0 ||
      (identity.bsd.pbi_start_tvsec == 0 &&
       identity.bsd.pbi_start_tvusec == 0)) {
    fail("PROCESS_IDENTITY_FIELDS_INVALID");
  }
  if (uuid_string(identity.uniq.p_uuid) != kExpectedServiceUuid) {
    fail("SERVICE_MAIN_EXECUTABLE_UUID_MISMATCH");
  }
  return identity;
}

bool same_process_identity(const ProcIdentity& first,
                           const ProcIdentity& second) {
  const proc_bsdinfo& a = first.bsd;
  const proc_bsdinfo& b = second.bsd;
  return first.pid == second.pid && first.path == second.path &&
         std::memcmp(&first.uniq, &second.uniq, sizeof(first.uniq)) == 0 &&
         a.pbi_pid == b.pbi_pid && a.pbi_ppid == b.pbi_ppid &&
         a.pbi_uid == b.pbi_uid && a.pbi_gid == b.pbi_gid &&
         a.pbi_ruid == b.pbi_ruid && a.pbi_rgid == b.pbi_rgid &&
         a.pbi_svuid == b.pbi_svuid && a.pbi_svgid == b.pbi_svgid &&
         a.pbi_pgid == b.pbi_pgid && a.pbi_start_tvsec == b.pbi_start_tvsec &&
         a.pbi_start_tvusec == b.pbi_start_tvusec &&
         std::memcmp(a.pbi_comm, b.pbi_comm, sizeof(a.pbi_comm)) == 0 &&
         std::memcmp(a.pbi_name, b.pbi_name, sizeof(a.pbi_name)) == 0;
}

IdentityKey identity_key(const ProcIdentity& identity) {
  return {identity.uniq.p_uniqueid, identity.uniq.p_idversion,
          identity.bsd.pbi_start_tvsec, identity.bsd.pbi_start_tvusec};
}

AuditIdentity query_audit_identity(mach_port_t task,
                                   const ProcIdentity& process) {
  AuditIdentity audit{};
  mach_msg_type_number_t count = TASK_AUDIT_TOKEN_COUNT;
  const kern_return_t kr = task_info(
      task, TASK_AUDIT_TOKEN, reinterpret_cast<task_info_t>(&audit.token),
      &count);
  if (kr != KERN_SUCCESS || count != TASK_AUDIT_TOKEN_COUNT) {
    fail("TASK_AUDIT_TOKEN_FAILED:" + std::to_string(kr));
  }
  audit.pid = audit_token_to_pid(audit.token);
  audit.pid_version = audit_token_to_pidversion(audit.token);
  audit.effective_uid = audit_token_to_euid(audit.token);
  audit.real_uid = audit_token_to_ruid(audit.token);
  if (audit.pid != process.pid ||
      audit.pid_version != process.uniq.p_idversion ||
      audit.effective_uid != process.bsd.pbi_uid ||
      audit.real_uid != process.bsd.pbi_ruid) {
    fail("TASK_AUDIT_TOKEN_PROCESS_IDENTITY_MISMATCH");
  }
  return audit;
}

bool same_audit_identity(const AuditIdentity& first,
                         const AuditIdentity& second) {
  return first.pid == second.pid &&
         first.pid_version == second.pid_version &&
         first.effective_uid == second.effective_uid &&
         first.real_uid == second.real_uid &&
         std::memcmp(&first.token, &second.token, sizeof(first.token)) == 0;
}

RegionIdentity query_rx_backing(pid_t pid, uint64_t address, size_t length,
                                uint64_t expected_file_offset,
                                const FileIdentity& expected_file) {
  proc_regionwithpathinfo region{};
  const int result = proc_pidinfo(
      pid, PROC_PIDREGIONPATHINFO, address, &region,
      static_cast<int>(sizeof(region)));
  if (result != static_cast<int>(sizeof(region))) {
    fail("PROC_PIDREGIONPATHINFO_FAILED_OR_SHORT:" +
         std::to_string(result) + ":" + std::to_string(errno));
  }
  const proc_regioninfo& info = region.prp_prinfo;
  if (info.pri_address > address || info.pri_size == 0 ||
      info.pri_address >
          std::numeric_limits<uint64_t>::max() - info.pri_size ||
      address > info.pri_address + info.pri_size ||
      length > info.pri_address + info.pri_size - address) {
    fail("REGION_DOES_NOT_CONTAIN_WINDOW");
  }
  const uint32_t rwx = info.pri_protection &
                       static_cast<uint32_t>(VM_PROT_READ | VM_PROT_WRITE |
                                             VM_PROT_EXECUTE);
  if (rwx != static_cast<uint32_t>(VM_PROT_READ | VM_PROT_EXECUTE)) {
    fail("WINDOW_REGION_NOT_EXACT_RX");
  }
  const char* raw_path = region.prp_vip.vip_path;
  const size_t path_length = strnlen(raw_path, MAXPATHLEN);
  if (path_length == MAXPATHLEN) {
    fail("REGION_PATH_NOT_NUL_TERMINATED");
  }
  const std::string path(raw_path, path_length);
  if (info.pri_offset > std::numeric_limits<uint64_t>::max() -
                            (address - info.pri_address) ||
      info.pri_offset + (address - info.pri_address) !=
          expected_file_offset) {
    fail("REGION_BACKING_FILE_OFFSET_MISMATCH");
  }
  const vinfo_stat& vnode = region.prp_vip.vip_vi.vi_stat;
  if (static_cast<uint64_t>(vnode.vst_dev) != expected_file.device ||
      vnode.vst_ino != expected_file.inode ||
      vnode.vst_size != expected_file.size) {
    fail("REGION_BACKING_VNODE_IDENTITY_MISMATCH");
  }
  return {info.pri_address,
          info.pri_size,
          info.pri_offset,
          info.pri_protection,
          info.pri_max_protection,
          info.pri_inheritance,
          info.pri_flags,
          info.pri_user_tag,
          info.pri_share_mode,
          info.pri_obj_id,
          vnode.vst_dev,
          vnode.vst_ino,
          vnode.vst_size,
          path};
}

FileIdentity query_target_file_identity() {
  struct stat status {};
  if (::stat(kTargetPath, &status) != 0) {
    fail("TARGET_FILE_STAT_FAILED:" + std::to_string(errno));
  }
  if (!S_ISREG(status.st_mode)) {
    fail("TARGET_FILE_NOT_REGULAR");
  }
  if (status.st_size != kExpectedTargetFileSize) {
    fail("TARGET_FILE_SIZE_MISMATCH:" + std::to_string(status.st_size));
  }
  return {static_cast<uint64_t>(status.st_dev),
          static_cast<uint64_t>(status.st_ino),
          static_cast<int64_t>(status.st_size),
          static_cast<int64_t>(status.st_mtimespec.tv_sec),
          static_cast<int64_t>(status.st_mtimespec.tv_nsec)};
}

bool same_file_identity(const FileIdentity& first,
                        const FileIdentity& second) {
  return first.device == second.device && first.inode == second.inode &&
         first.size == second.size &&
         first.mtime_seconds == second.mtime_seconds &&
         first.mtime_nanoseconds == second.mtime_nanoseconds;
}

void validate_target_file_unchanged(const FileIdentity& before) {
  const FileIdentity after = query_target_file_identity();
  if (!same_file_identity(before, after)) {
    fail("TARGET_FILE_IDENTITY_CHANGED_POST_READ");
  }
}

bool same_region_identity(const RegionIdentity& first,
                          const RegionIdentity& second) {
  return first.address == second.address && first.size == second.size &&
         first.file_offset == second.file_offset &&
         first.protection == second.protection &&
         first.max_protection == second.max_protection &&
         first.inheritance == second.inheritance &&
         first.flags == second.flags && first.user_tag == second.user_tag &&
         first.share_mode == second.share_mode &&
         first.object_id == second.object_id &&
         first.vnode_device == second.vnode_device &&
         first.vnode_inode == second.vnode_inode &&
         first.vnode_size == second.vnode_size && first.path == second.path;
}

void validate_final_process_and_token(pid_t pid, const ProcIdentity& before,
                                      mach_port_t task,
                                      const AuditIdentity& audit_before) {
  const ProcIdentity after = query_process_identity(pid);
  if (!same_process_identity(before, after)) {
    fail("PROCESS_IDENTITY_CHANGED_POST_READ");
  }
  const AuditIdentity audit_after = query_audit_identity(task, after);
  if (!same_audit_identity(audit_before, audit_after)) {
    fail("TASK_AUDIT_TOKEN_CHANGED_POST_READ");
  }
}

void validate_final_target_record(mach_port_t task,
                                  const DyldImageRecord& before) {
  const std::vector<DyldImageRecord> after_records = stable_dyld_images(task);
  DyldImageRecord after{};
  if (!find_exact_target_record(after_records, &after)) {
    fail("DYLD_32023_IMAGE_DISAPPEARED_POST_READ");
  }
  if (after.header_address != before.header_address ||
      after.path != before.path) {
    fail("DYLD_32023_RECORD_CHANGED_POST_READ");
  }
}

CaptureResult capture_instance(const ProcIdentity& process, unsigned attempt,
                               const FileIdentity& target_file_before) {
  const IdentityKey key = identity_key(process);
  std::cout << "PID_CAPTURE_BEGIN=PID=" << process.pid
            << "|P_UNIQUEID=" << key.unique_id
            << "|P_IDVERSION=" << key.id_version
            << "|START_SEC=" << key.start_seconds
            << "|START_USEC=" << key.start_microseconds
            << "|ATTEMPT=" << attempt << '\n';

  mach_port_t raw_port = MACH_PORT_NULL;
  errno = 0;
  const int task_result = task_read_for_pid(
      mach_task_self(), process.pid, reinterpret_cast<unsigned int*>(&raw_port));
  const int task_errno = errno;
  if (task_result != KERN_SUCCESS || raw_port == MACH_PORT_NULL) {
    bool stray_port_deallocated = true;
    if (raw_port != MACH_PORT_NULL) {
      stray_port_deallocated =
          mach_port_deallocate(mach_task_self(), raw_port) == KERN_SUCCESS;
    }
    bool same_identity_still_live = false;
    try {
      const ProcIdentity after_failure = query_process_identity(process.pid);
      same_identity_still_live = same_process_identity(process, after_failure);
    } catch (const std::exception&) {
      same_identity_still_live = false;
    }
    validate_target_file_unchanged(target_file_before);
    std::cout << "PID_TASK_READ_ACCESS="
              << (same_identity_still_live ? "DENIED_OR_UNAVAILABLE"
                                           : "PROCESS_EXIT_OR_PID_REUSE_RACE")
              << "|PID=" << process.pid << "|RETURN=" << task_result
              << "|ERRNO=" << task_errno << "|STRAY_PORT_DEALLOCATED="
              << (stray_port_deallocated ? "YES" : "FAIL") << '\n';
    if (!stray_port_deallocated) {
      return {CaptureKind::kFatal, "STRAY_TASK_PORT_DEALLOCATE_FAILED"};
    }
    if (!same_identity_still_live) {
      return {CaptureKind::kRaceIncomplete,
              "PROCESS_EXIT_OR_PID_REUSE_RACE_BEFORE_TASK_READ"};
    }
    return {CaptureKind::kFatal, "LIVE_BYTES_BLOCKED_BY_TASK_PORT_POLICY"};
  }

  TaskPort task(raw_port);
  try {
    const AuditIdentity audit_before = query_audit_identity(task.get(), process);
    const std::vector<DyldImageRecord> records = stable_dyld_images(task.get());
    DyldImageRecord target{};
    if (!find_exact_target_record(records, &target)) {
      validate_final_process_and_token(process.pid, process, task.get(),
                                       audit_before);
      validate_target_file_unchanged(target_file_before);
      if (!task.close()) {
        fail("TASK_READ_PORT_DEALLOCATE_FAILED");
      }
      std::cout << "PID_TASK_READ_PORT_DEALLOCATED=YES|PID=" << process.pid
                << '\n';
      std::cout << "PID_CAPTURE_RESULT=IMAGE_32023_NOT_YET_PRESENT|PID="
                << process.pid << "|UUID_PROVEN=UNKNOWN"
                << "|PATCH_POSTIMAGE_BYTES_PROVEN=UNKNOWN"
                << "|INVARIANT_FINGERPRINT=UNKNOWN"
                << "|BOUNDED_31_PROVENANCE=UNKNOWN\n";
      return {CaptureKind::kNotReady, "IMAGE_32023_NOT_YET_PRESENT"};
    }

    const std::vector<uint8_t> initial_header =
        stable_remote_macho(task.get(), target.header_address);
    const MachoIdentity macho = parse_macho(initial_header);
    const std::string runtime_uuid = uuid_string(macho.uuid.data());
    std::cout << "PID_RUNTIME_IMAGE_IDENTITY=PID=" << process.pid
              << "|PATH=" << target.path << "|HEADER=0x" << std::hex
              << target.header_address << std::dec << "|LC_UUID="
              << runtime_uuid << "|HEADER_BYTES=" << initial_header.size()
              << '\n';

    if (runtime_uuid != kExpectedTargetUuid) {
      validate_final_target_record(task.get(), target);
      const std::vector<uint8_t> final_header =
          stable_remote_macho(task.get(), target.header_address);
      if (final_header != initial_header) {
        fail("REMOTE_MACHO_HEADER_CHANGED_POST_UUID_GATE");
      }
      validate_final_process_and_token(process.pid, process, task.get(),
                                       audit_before);
      validate_target_file_unchanged(target_file_before);
      if (!task.close()) {
        fail("TASK_READ_PORT_DEALLOCATE_FAILED");
      }
      std::cout << "PID_TASK_READ_PORT_DEALLOCATED=YES|PID=" << process.pid
                << '\n';
      std::cout << "PID_CAPTURE_RESULT=UUID_NEGATIVE_OFFSETS_SKIPPED|PID="
                << process.pid << "|UUID_PROVEN=NEGATIVE"
                << "|PATCH_POSTIMAGE_BYTES_PROVEN=UNKNOWN"
                << "|INVARIANT_FINGERPRINT=UNKNOWN"
                << "|BOUNDED_31_PROVENANCE=UNKNOWN"
                << "|FULL_IMAGE_SHA_CLAIM=NOT_MADE\n";
      return {CaptureKind::kUuidNegative, "RUNTIME_UUID_NOT_D5CE"};
    }

    validate_expected_topology(macho);
    if (initial_header.size() != kExpectedHeaderBytes) {
      fail("D5CE_HEADER_PLUS_LOAD_COMMAND_SIZE_MISMATCH");
    }
    std::cout << "PID_D5CE_GATE=PASS|PID=" << process.pid
              << "|UUID_PROVEN=YES|PATH_EXACT=YES|TOPOLOGY_EXACT=YES"
              << "|TEXT_VMADDR=0x" << std::hex << macho.text.vmaddr
              << "|TEXT_VMSIZE=0x" << macho.text.vmsize
              << "|TEXT_FILEOFF=0x" << macho.text.fileoff
              << "|TEXT_FILESIZE=0x" << macho.text.filesize << std::dec
              << '\n';

    std::vector<RegionIdentity> regions_before;
    regions_before.reserve(kWindows.size());
    size_t total_bytes = 0;
    size_t expected_post_or_invariant = 0;
    size_t d97_post = 0;
    size_t retained_post = 0;
    size_t stub_post = 0;
    size_t late_match = 0;
    size_t far_match = 0;

    for (const WindowSpec& spec : kWindows) {
      const uint64_t runtime_address = runtime_address_for_file_offset(
          macho, target.header_address, spec.file_offset, spec.length);
      regions_before.push_back(query_rx_backing(
          process.pid, runtime_address, spec.length, spec.file_offset,
          target_file_before));
      const std::vector<uint8_t> actual =
          stable_read(task.get(), runtime_address, spec.length);
      const std::string state = classify_window(spec, actual);
      const bool expected = is_invariant(spec.role)
                                ? state == "INVARIANT_MATCH"
                                : state == "POST";
      expected_post_or_invariant += expected ? 1U : 0U;
      if (spec.role == Role::kD97adSite && state == "POST") {
        ++d97_post;
      } else if (spec.role == Role::kStub && state == "POST") {
        ++stub_post;
      } else if (spec.role == Role::kRetained && state == "POST") {
        ++retained_post;
      } else if (spec.role == Role::kLateInvariant &&
                 state == "INVARIANT_MATCH") {
        ++late_match;
      } else if (spec.role == Role::kFarInvariant &&
                 state == "INVARIANT_MATCH") {
        ++far_match;
      }
      total_bytes += spec.length;
      std::cout << "PID_WINDOW=PID=" << process.pid << "|NAME="
                << spec.name << "|ROLE=" << role_name(spec.role)
                << "|FILEOFF=0x" << std::hex << spec.file_offset
                << "|RUNTIME_VA=0x" << runtime_address << std::dec
                << "|LEN=" << spec.length << "|ACTUAL="
                << hex_bytes(actual) << "|PRE=" << spec.pre_hex
                << "|POST=" << spec.post_hex << "|STATE=" << state
                << "|DOUBLE_READ_STABLE=YES|RX_BACKING_VNODE_MATCH=YES"
                << "|BACKING_PATH=" << regions_before.back().path
                << "|BACKING_DEV=" << regions_before.back().vnode_device
                << "|BACKING_INODE=" << regions_before.back().vnode_inode
                << "|BACKING_SIZE=" << regions_before.back().vnode_size
                << '\n';
    }
    if (total_bytes != 330) {
      fail("RUNTIME_WINDOW_TOTAL_NOT_330");
    }

    for (size_t i = 0; i < kWindows.size(); ++i) {
      const WindowSpec& spec = kWindows[i];
      const uint64_t runtime_address = runtime_address_for_file_offset(
          macho, target.header_address, spec.file_offset, spec.length);
      const RegionIdentity after = query_rx_backing(
          process.pid, runtime_address, spec.length, spec.file_offset,
          target_file_before);
      if (!same_region_identity(regions_before[i], after)) {
        fail(std::string("REGION_IDENTITY_CHANGED_POST_READ:") + spec.name);
      }
    }
    validate_final_target_record(task.get(), target);
    const std::vector<uint8_t> final_header =
        stable_remote_macho(task.get(), target.header_address);
    if (final_header != initial_header) {
      fail("REMOTE_MACHO_HEADER_CHANGED_POST_WINDOWS");
    }
    validate_final_process_and_token(process.pid, process, task.get(),
                                     audit_before);
    validate_target_file_unchanged(target_file_before);

    const EvidenceFlags evidence =
        aggregate_evidence(d97_post, stub_post, retained_post, late_match,
                           far_match, expected_post_or_invariant);
    std::cout << "PID_WINDOW_SUMMARY=PID=" << process.pid
              << "|ENTRIES=31|BOUNDED_BYTES_PER_PASS=330"
              << "|DOUBLE_READ_BYTES=660|D97AD_POST=" << d97_post
              << "/6|STUB_POST=" << stub_post << "/1|RETAINED_POST="
              << retained_post << "/16|LATE_INVARIANT=" << late_match
              << "/6|FAR_INVARIANT=" << far_match << "/2\n";
    std::cout << "PID_PROVENANCE_RESULT=PID=" << process.pid
              << "|UUID_PROVEN=YES|PATCH_POSTIMAGE_BYTES_PROVEN="
              << (evidence.patch_windows_match ? "YES" : "NEGATIVE")
              << "|INVARIANT_FINGERPRINT="
              << (evidence.invariant_fingerprint_match ? "MATCH"
                                                       : "MISMATCH")
              << "|BOUNDED_31_WINDOW_PROVENANCE="
              << (evidence.all_31_provenance_match ? "MATCH" : "MISMATCH")
              << "|FULL_IMAGE_SHA_CLAIM=NOT_MADE\n";
    std::cout << "PID_RUNTIME_D97AD_PATCH_WINDOWS="
              << (evidence.patch_windows_match ? "MATCH" : "MISMATCH")
              << "|SEMANTIC_LABEL="
              << (evidence.patch_windows_match
                      ? "RUNTIME_D97AD_PATCH_WINDOWS_MATCH"
                      : "RUNTIME_D97AD_PATCH_WINDOWS_MISMATCH")
              << "|SCOPE=23_PATCH_WINDOWS_202_BYTES|PID=" << process.pid
              << '\n';
    std::cout << "PID_INVARIANT_FINGERPRINT="
              << (evidence.invariant_fingerprint_match ? "MATCH"
                                                       : "MISMATCH")
              << "|SCOPE=8_LATE_FAR_WINDOWS_128_BYTES|PID=" << process.pid
              << '\n';
    std::cout << "PID_BOUNDED_31_WINDOW_PROVENANCE="
              << (evidence.all_31_provenance_match ? "MATCH" : "MISMATCH")
              << "|SCOPE=31_WINDOWS_330_BYTES|PID=" << process.pid
              << '\n';
    if (!task.close()) {
      fail("TASK_READ_PORT_DEALLOCATE_FAILED");
    }
    std::cout << "PID_TASK_READ_PORT_DEALLOCATED=YES|PID=" << process.pid
              << '\n';
    return {evidence.all_31_provenance_match
                ? CaptureKind::kCompleteProvenanceMatch
                : CaptureKind::kCompleteProvenanceMismatch,
            evidence.all_31_provenance_match
                ? "ALL_31_EXPECTED_WINDOWS_STABLE"
                : "STABLE_BOUNDED_31_WINDOW_PROVENANCE_MISMATCH"};
  } catch (const std::exception& error) {
    const bool deallocated = task.close();
    bool process_still_exact = false;
    std::array<char, PROC_PIDPATHINFO_MAXSIZE> path{};
    const int path_result = proc_pidpath(
        process.pid, path.data(), static_cast<uint32_t>(path.size()));
    if (path_result > 0 && strnlen(path.data(), path.size()) < path.size()) {
      process_still_exact = std::string(path.data()) == kServicePath;
    }
    bool target_file_stable = false;
    try {
      validate_target_file_unchanged(target_file_before);
      target_file_stable = true;
    } catch (const std::exception&) {
      target_file_stable = false;
    }
    std::cout << "PID_TASK_READ_PORT_DEALLOCATED="
              << (deallocated ? "YES" : "FAIL") << "|PID=" << process.pid
              << '\n';
    std::cout << "PID_CAPTURE_RESULT=INCONCLUSIVE_STOP|PID=" << process.pid
              << "|UUID_PROVEN=UNKNOWN|PATCH_POSTIMAGE_BYTES_PROVEN=UNKNOWN"
              << "|INVARIANT_FINGERPRINT=UNKNOWN"
              << "|BOUNDED_31_PROVENANCE=UNKNOWN"
              << "|REASON=" << error.what()
              << "|PROCESS_STILL_EXACT="
              << (process_still_exact ? "YES" : "NO")
              << "|TARGET_FILE_STABLE="
              << (target_file_stable ? "YES" : "NO") << '\n';
    if (deallocated && target_file_stable && !process_still_exact) {
      return {CaptureKind::kRaceIncomplete,
              std::string("PROCESS_EXIT_RACE_DURING_CAPTURE:") +
                  error.what()};
    }
    return {CaptureKind::kFatal, error.what()};
  }
}

std::vector<pid_t> all_pids() {
  int estimated = proc_listallpids(nullptr, 0);
  if (estimated <= 0) {
    fail("PROC_LISTALLPIDS_SIZE_FAILED:" + std::to_string(errno));
  }
  for (unsigned retry = 0; retry < 4; ++retry) {
    const size_t capacity = static_cast<size_t>(estimated) + 256U;
    if (capacity > static_cast<size_t>(std::numeric_limits<int>::max()) /
                       sizeof(pid_t)) {
      fail("PROC_LISTALLPIDS_CAPACITY_OVERFLOW");
    }
    std::vector<pid_t> pids(capacity);
    const int count = proc_listallpids(
        pids.data(), static_cast<int>(pids.size() * sizeof(pid_t)));
    if (count <= 0) {
      fail("PROC_LISTALLPIDS_FAILED:" + std::to_string(errno));
    }
    if (static_cast<size_t>(count) < pids.size()) {
      pids.resize(static_cast<size_t>(count));
      pids.erase(std::remove_if(pids.begin(), pids.end(),
                                [](pid_t pid) { return pid <= 0; }),
                 pids.end());
      std::sort(pids.begin(), pids.end());
      pids.erase(std::unique(pids.begin(), pids.end()), pids.end());
      return pids;
    }
    estimated = count + 256;
  }
  fail("PROC_LISTALLPIDS_UNSTABLE_CARDINALITY");
}

bool parse_unsigned(const std::string& text, unsigned minimum,
                    unsigned maximum, unsigned* output) {
  if (text.empty() ||
      !std::all_of(text.begin(), text.end(),
                   [](char c) { return c >= '0' && c <= '9'; })) {
    return false;
  }
  errno = 0;
  char* end = nullptr;
  const unsigned long value = std::strtoul(text.c_str(), &end, 10);
  if (errno != 0 || end == nullptr || *end != '\0' || value < minimum ||
      value > maximum) {
    return false;
  }
  *output = static_cast<unsigned>(value);
  return true;
}

Options parse_options(int argc, char** argv) {
  Options options{};
  if (argc == 2 && std::string(argv[1]) == "--self-test") {
    options.self_test = true;
    return options;
  }
  for (int i = 1; i < argc; ++i) {
    const std::string argument(argv[i]);
    std::string name = argument;
    std::string value;
    const size_t equals = argument.find('=');
    if (equals != std::string::npos) {
      name = argument.substr(0, equals);
      value = argument.substr(equals + 1);
    } else {
      if (i + 1 >= argc) {
        fail("OPTION_VALUE_MISSING:" + name);
      }
      value = argv[++i];
    }
    if (name == "--duration") {
      if (!parse_unsigned(value, 1, kMaximumDurationSeconds,
                          &options.duration_seconds)) {
        fail("OPTION_DURATION_INVALID");
      }
    } else if (name == "--interval-ms") {
      if (!parse_unsigned(value, kMinimumIntervalMilliseconds,
                          kMaximumIntervalMilliseconds,
                          &options.interval_milliseconds)) {
        fail("OPTION_INTERVAL_INVALID");
      }
    } else if (name == "--min-complete") {
      if (!parse_unsigned(value, 1, kMaximumMinimumComplete,
                          &options.minimum_complete)) {
        fail("OPTION_MIN_COMPLETE_INVALID");
      }
    } else {
      fail("OPTION_NOT_ALLOWED:" + name);
    }
  }
  return options;
}

std::vector<uint8_t> synthetic_expected_macho() {
  std::vector<uint8_t> bytes(kExpectedHeaderBytes, 0);
  mach_header_64 header{};
  header.magic = MH_MAGIC_64;
  header.cputype = static_cast<cpu_type_t>(kExpectedCpuType);
  header.cpusubtype = static_cast<cpu_subtype_t>(kExpectedCpuSubtype);
  header.filetype = kExpectedFileType;
  header.ncmds = kExpectedNcmds;
  header.sizeofcmds = kExpectedSizeofcmds;
  std::memcpy(bytes.data(), &header, sizeof(header));

  size_t cursor = sizeof(header);
  segment_command_64 text{};
  text.cmd = LC_SEGMENT_64;
  text.cmdsize = sizeof(text);
  std::memcpy(text.segname, "__TEXT", 6);
  text.vmaddr = kExpectedTextVmaddr;
  text.vmsize = kExpectedTextVmsize;
  text.fileoff = kExpectedTextFileoff;
  text.filesize = kExpectedTextFilesize;
  text.maxprot = VM_PROT_READ | VM_PROT_EXECUTE;
  text.initprot = VM_PROT_READ | VM_PROT_EXECUTE;
  std::memcpy(bytes.data() + cursor, &text, sizeof(text));
  cursor += sizeof(text);

  uuid_command uuid{};
  uuid.cmd = LC_UUID;
  uuid.cmdsize = sizeof(uuid);
  const std::array<uint8_t, 16> expected_uuid = {{
      0xD5, 0xCE, 0x00, 0x08, 0x58, 0x7C, 0x38, 0x61,
      0x97, 0x1A, 0x4B, 0xAE, 0xFB, 0x7B, 0x9C, 0x5B,
  }};
  std::copy(expected_uuid.begin(), expected_uuid.end(), std::begin(uuid.uuid));
  std::memcpy(bytes.data() + cursor, &uuid, sizeof(uuid));
  cursor += sizeof(uuid);

  for (unsigned i = 0; i < 22; ++i) {
    load_command filler{};
    filler.cmd = 0x7FFFFFFEU;
    filler.cmdsize = sizeof(filler);
    std::memcpy(bytes.data() + cursor, &filler, sizeof(filler));
    cursor += sizeof(filler);
  }
  load_command final_filler{};
  final_filler.cmd = 0x7FFFFFFDU;
  final_filler.cmdsize =
      static_cast<uint32_t>(bytes.size() - cursor);
  std::memcpy(bytes.data() + cursor, &final_filler, sizeof(final_filler));
  cursor += final_filler.cmdsize;
  if (cursor != bytes.size()) {
    fail("SELF_TEST_SYNTHETIC_MACHO_SIZE_MISMATCH");
  }
  return bytes;
}

int run_self_test() {
  validate_manifest();
  for (const WindowSpec& spec : kWindows) {
    const std::vector<uint8_t> pre = decode_hex(spec.pre_hex);
    const std::vector<uint8_t> post = decode_hex(spec.post_hex);
    if (is_invariant(spec.role)) {
      if (classify_window(spec, post) != "INVARIANT_MATCH") {
        fail(std::string("SELF_TEST_INVARIANT_CLASSIFY_FAIL:") + spec.name);
      }
    } else {
      if (classify_window(spec, pre) != "PRE" ||
          classify_window(spec, post) != "POST") {
        fail(std::string("SELF_TEST_PRE_POST_CLASSIFY_FAIL:") + spec.name);
      }
    }
    std::vector<uint8_t> other = post;
    other[0] ^= 0xFFU;
    if (classify_window(spec, other) != "OTHER") {
      fail(std::string("SELF_TEST_OTHER_CLASSIFY_FAIL:") + spec.name);
    }
  }

  const EvidenceFlags all_match = aggregate_evidence(6, 1, 16, 6, 2, 31);
  if (!all_match.patch_windows_match ||
      !all_match.invariant_fingerprint_match ||
      !all_match.all_31_provenance_match) {
    fail("SELF_TEST_AGGREGATE_ALL_MATCH_FAIL");
  }
  for (const WindowSpec& spec : kWindows) {
    size_t d97_post = 6;
    size_t stub_post = 1;
    size_t retained_post = 16;
    size_t late_match = 6;
    size_t far_match = 2;
    switch (spec.role) {
      case Role::kD97adSite:
        --d97_post;
        break;
      case Role::kStub:
        --stub_post;
        break;
      case Role::kRetained:
        --retained_post;
        break;
      case Role::kLateInvariant:
        --late_match;
        break;
      case Role::kFarInvariant:
        --far_match;
        break;
    }
    const EvidenceFlags mismatch =
        aggregate_evidence(d97_post, stub_post, retained_post, late_match,
                           far_match, 30);
    const bool patch_role = spec.role == Role::kD97adSite ||
                            spec.role == Role::kStub ||
                            spec.role == Role::kRetained;
    if (patch_role) {
      if (mismatch.patch_windows_match ||
          !mismatch.invariant_fingerprint_match ||
          mismatch.all_31_provenance_match) {
        fail(std::string("SELF_TEST_PATCH_AGGREGATE_FAIL:") + spec.name);
      }
    } else if (!mismatch.patch_windows_match ||
               mismatch.invariant_fingerprint_match ||
               mismatch.all_31_provenance_match) {
      fail(std::string("SELF_TEST_INVARIANT_AGGREGATE_FAIL:") + spec.name);
    }
  }

  const std::vector<uint8_t> bytes = synthetic_expected_macho();
  const MachoIdentity macho = parse_macho(bytes);
  validate_expected_topology(macho);
  if (uuid_string(macho.uuid.data()) != kExpectedTargetUuid) {
    fail("SELF_TEST_UUID_FORMAT_OR_PARSE_FAIL");
  }
  const uint64_t synthetic_header = 0x100000000ULL;
  for (const WindowSpec& spec : kWindows) {
    const uint64_t address = runtime_address_for_file_offset(
        macho, synthetic_header, spec.file_offset, spec.length);
    if (address != synthetic_header + spec.file_offset) {
      fail(std::string("SELF_TEST_SEGMENT_TRANSLATION_FAIL:") + spec.name);
    }
  }
  std::vector<uint8_t> bad = bytes;
  bad[0] ^= 1U;
  bool rejected = false;
  try {
    static_cast<void>(parse_macho(bad));
  } catch (const std::exception&) {
    rejected = true;
  }
  if (!rejected) {
    fail("SELF_TEST_BAD_MACHO_NOT_REJECTED");
  }

  std::cout << "D97AEX_SELF_TEST_MANIFEST=PASS|ENTRIES=31|BYTES=330\n";
  std::cout << "D97AEX_SELF_TEST_CLASSIFIER=PASS|PRE_POST_OTHER_INVARIANT\n";
  std::cout << "D97AEX_SELF_TEST_AGGREGATION=PASS"
            << "|PATCH_MISMATCH_CASES=23|INVARIANT_MISMATCH_CASES=8\n";
  std::cout << "D97AEX_SELF_TEST_MACHO=PASS|HEADER_BYTES=3832|UUID_D5CE=YES"
            << "|TOPOLOGY=EXACT\n";
  std::cout << "D97AEX_SELF_TEST_SEGMENT_TRANSLATION=PASS|WINDOWS=31\n";
  std::cout << "D97AEX_SELF_TEST=PASS\n";
  return 0;
}

void print_contract(const Options& options) {
  std::cout << "===== OCLP7 D97AEX READ-ONLY D5CE RUNTIME TEXT PROVENANCE =====\n";
  std::cout << "MODE=FINITE_POLL_SAMPLED_NO_PID_NATURAL_INSTANCE_WATCHER\n";
  std::cout << "SELECTION_SCOPE=ALL_EXACT_PATH_PIDS_VISIBLE_AT_EACH_POLL\n";
  std::cout << "GLOBAL_SPAWN_COHORT_COVERAGE=UNKNOWN\n";
  std::cout << "TARGET_SERVICE_PATH=" << kServicePath << '\n';
  std::cout << "TARGET_IMAGE_PATH=" << kTargetPath << '\n';
  std::cout << "EXPECTED_RUNTIME_LC_UUID=" << kExpectedTargetUuid << '\n';
  std::cout << "TASK_PORT_API=task_read_for_pid\n";
  std::cout << "TASK_PORT_FLAVOR=TASK_FLAVOR_READ\n";
  std::cout << "RUNTIME_INSTRUMENTATION=YES_APPLE_PRIVATE_TASK_READ_PORT\n";
  std::cout << "OBSERVATIONAL_PERTURBATION=POSSIBLE_PAGE_IN_AND_TIMING\n";
  std::cout << "SOURCE_MUTATION=NO\n";
  std::cout << "SYSTEM_FILE_MUTATION=NO\n";
  std::cout << "GOLDEN_MUTATION=NO\n";
  std::cout << "TARGET_CODE_BYTES_MUTATION=NO\n";
  std::cout << "TARGET_PROCESS_CONTROL_MUTATION=NO\n";
  std::cout << "SERVICE_LAUNCH=AUTO-NO\n";
  std::cout << "ROOT_PATCH=AUTO-NO\n";
  std::cout << "REBOOT=AUTO-NO\n";
  std::cout << "FULL_IMAGE_SHA_CLAIM=NOT_MADE\n";
  std::cout << "BRANCH_EXECUTION_CLAIM=NOT_MADE\n";
  std::cout << "EXPECTED_WRAPPER_SERVICE_SHA256="
            << kExpectedServiceSha256 << '\n';
  std::cout << "EXPECTED_WRAPPER_TARGET_SHA256="
            << kExpectedVisibleTargetSha256 << '\n';
  std::cout << "FILESYSTEM_SHA256_GATE=OUT_OF_SCOPE_WRAPPER_PRE_POST\n";
  std::cout << "WINDOW_MANIFEST=31_ENTRIES_330_BYTES_PER_PASS_660_DOUBLE_READ\n";
  std::cout << "WATCH_DURATION_SECONDS=" << options.duration_seconds << '\n';
  std::cout << "WATCH_INTERVAL_MILLISECONDS="
            << options.interval_milliseconds << '\n';
  std::cout << "MINIMUM_COMPLETE_INSTANCES=" << options.minimum_complete
            << '\n';
}

int run_watcher(const Options& options) {
  validate_manifest();
  print_contract(options);

  FileIdentity target_file_before{};
  try {
    target_file_before = query_target_file_identity();
  } catch (const std::exception& error) {
    std::cout << "D97AEX_STOP=TARGET_FILE_PRE_IDENTITY_FAILED|REASON="
              << error.what() << '\n';
    return 2;
  }
  std::cout << "TARGET_FILE_PRE_IDENTITY=DEV=" << target_file_before.device
            << "|INODE=" << target_file_before.inode
            << "|SIZE=" << target_file_before.size
            << "|MTIME_SEC=" << target_file_before.mtime_seconds
            << "|MTIME_NSEC=" << target_file_before.mtime_nanoseconds
            << "|LOGICAL_PATH=" << kTargetPath << '\n';

  std::map<IdentityKey, InstanceState> instances;
  size_t complete_count = 0;
  size_t complete_provenance_match_count = 0;
  size_t complete_provenance_mismatch_count = 0;
  size_t uuid_negative_count = 0;
  size_t race_incomplete_count = 0;
  size_t preidentity_race_count = 0;
  size_t polls = 0;
  const auto deadline = std::chrono::steady_clock::now() +
                        std::chrono::seconds(options.duration_seconds);

  while (std::chrono::steady_clock::now() < deadline) {
    ++polls;
    std::vector<pid_t> pids;
    try {
      pids = all_pids();
    } catch (const std::exception& error) {
      std::cout << "D97AEX_STOP=PROCESS_ENUMERATION_FAILED|REASON="
                << error.what() << '\n';
      return 2;
    }
    for (pid_t pid : pids) {
      std::array<char, PROC_PIDPATHINFO_MAXSIZE> path{};
      const int path_result = proc_pidpath(
          pid, path.data(), static_cast<uint32_t>(path.size()));
      const size_t path_length = strnlen(path.data(), path.size());
      if (path_result <= 0 || path_length == path.size() ||
          std::string(path.data(), path_length) != kServicePath) {
        continue;
      }

      ProcIdentity identity{};
      try {
        identity = query_process_identity(pid);
      } catch (const std::exception& error) {
        ++preidentity_race_count;
        std::cout << "DISCOVERED_SERVICE_RACE=EXACT_PATH_PREFILTER_BUT_"
                     "IDENTITY_NOT_STABLE|PID="
                  << pid << "|PATCH_POSTIMAGE_BYTES_PROVEN=UNKNOWN"
                  << "|INVARIANT_FINGERPRINT=UNKNOWN"
                  << "|BOUNDED_31_PROVENANCE=UNKNOWN|REASON="
                  << error.what() << '\n';
        continue;
      }
      const IdentityKey key = identity_key(identity);
      InstanceState& state = instances[key];
      state.last_pid = pid;
      if (state.terminal) {
        continue;
      }
      ++state.attempts;
      const CaptureResult capture =
          capture_instance(identity, state.attempts, target_file_before);
      if (capture.kind == CaptureKind::kFatal) {
        std::cout << "D97AEX_STOP=FAIL_CLOSED|PID=" << pid
                  << "|REASON=" << capture.reason << '\n';
        std::cout << "COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=UNKNOWN\n";
        return 2;
      }
      if (capture.kind == CaptureKind::kNotReady) {
        continue;
      }
      state.terminal = true;
      state.terminal_kind = capture.kind;
      if (capture.kind == CaptureKind::kRaceIncomplete) {
        ++race_incomplete_count;
      } else if (capture.kind == CaptureKind::kUuidNegative) {
        ++uuid_negative_count;
      } else {
        ++complete_count;
        if (capture.kind == CaptureKind::kCompleteProvenanceMatch) {
          ++complete_provenance_match_count;
        } else if (capture.kind == CaptureKind::kCompleteProvenanceMismatch) {
          ++complete_provenance_mismatch_count;
        }
      }
    }
    std::this_thread::sleep_for(
        std::chrono::milliseconds(options.interval_milliseconds));
  }

  FileIdentity target_file_after{};
  try {
    target_file_after = query_target_file_identity();
  } catch (const std::exception& error) {
    std::cout << "D97AEX_STOP=TARGET_FILE_POST_IDENTITY_FAILED|REASON="
              << error.what() << '\n';
    return 2;
  }
  std::cout << "TARGET_FILE_POST_IDENTITY=DEV=" << target_file_after.device
            << "|INODE=" << target_file_after.inode
            << "|SIZE=" << target_file_after.size
            << "|MTIME_SEC=" << target_file_after.mtime_seconds
            << "|MTIME_NSEC=" << target_file_after.mtime_nanoseconds
            << "|LOGICAL_PATH=" << kTargetPath << '\n';
  if (!same_file_identity(target_file_before, target_file_after)) {
    std::cout << "D97AEX_STOP=TARGET_FILE_IDENTITY_CHANGED_DURING_WATCH\n";
    std::cout << "COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=UNKNOWN\n";
    return 2;
  }

  size_t pending_count = 0;
  for (const auto& entry : instances) {
    if (!entry.second.terminal) {
      ++pending_count;
      std::cout << "PID_FINAL_STATE=PID=" << entry.second.last_pid
                << "|STATE=OBSERVED_BUT_NOT_COMPLETELY_CAPTURED"
                << "|PATCH_POSTIMAGE_BYTES_PROVEN=UNKNOWN"
                << "|INVARIANT_FINGERPRINT=UNKNOWN"
                << "|BOUNDED_31_PROVENANCE=UNKNOWN\n";
    }
  }

  std::cout << "COHORT_SUMMARY=POLLS=" << polls
            << "|UNIQUE_EXACT_SERVICE_INSTANCES=" << instances.size()
            << "|COMPLETE_D5CE_INSTANCES=" << complete_count
            << "|COMPLETE_BOUNDED31_MATCH="
            << complete_provenance_match_count
            << "|COMPLETE_BOUNDED31_MISMATCH="
            << complete_provenance_mismatch_count
            << "|UUID_NEGATIVE_OFFSETS_SKIPPED=" << uuid_negative_count
            << "|CAPTURE_EXIT_RACE_INCOMPLETE=" << race_incomplete_count
            << "|PREFILTER_IDENTITY_RACE_INCOMPLETE="
            << preidentity_race_count
            << "|PENDING_OR_ENDED_INCOMPLETE=" << pending_count
            << "|MINIMUM_REQUIRED=" << options.minimum_complete << '\n';
  std::cout << "COHORT_DISCOVERY_SCOPE=POLL_SAMPLED_NO_PID"
            << "|ALL_DISCOVERED_EXACT_IDENTITIES=" << instances.size()
            << "|INTER_POLL_INSTANCE_VISIBILITY=NOT_GUARANTEED\n";

  if (complete_count < options.minimum_complete || pending_count != 0 ||
      uuid_negative_count != 0 || race_incomplete_count != 0 ||
      preidentity_race_count != 0) {
    std::cout << "COHORT_COVERAGE=INCOMPLETE\n";
    std::cout << "COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=UNKNOWN\n";
    std::cout << "D97AEX_RESULT=COVERAGE_INCOMPLETE_STOP\n";
    return 3;
  }
  if (complete_provenance_mismatch_count != 0) {
    std::cout << "COHORT_COVERAGE=ALL_DISCOVERED_EXACT_INSTANCES_COMPLETE\n";
    std::cout << "COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=NEGATIVE\n";
    std::cout << "COHORT_BOUNDED_31_WINDOW_PROVENANCE=MISMATCH\n";
    std::cout << "D97AEX_RESULT=OBSERVED_COHORT_BOUNDED_31_WINDOW_"
                 "PROVENANCE_MISMATCH\n";
    return 4;
  }
  std::cout << "COHORT_COVERAGE=ALL_DISCOVERED_EXACT_INSTANCES_COMPLETE\n";
  std::cout << "COHORT_BOUNDED_31_WINDOW_BYTES_PROVEN=YES"
            << "|SCOPE=OBSERVED_COHORT_31_WINDOWS_330_BYTES_EACH\n";
  std::cout << "COHORT_BOUNDED_31_WINDOW_PROVENANCE=MATCH\n";
  std::cout << "D97AEX_RESULT=OBSERVED_COHORT_BOUNDED_31_WINDOW_"
               "PROVENANCE_MATCH\n";
  return 0;
}

}  // namespace

int main(int argc, char** argv) {
  std::cout.setf(std::ios::unitbuf);
  try {
    const Options options = parse_options(argc, argv);
    if (options.self_test) {
      return run_self_test();
    }
    return run_watcher(options);
  } catch (const std::exception& error) {
    std::cout << "D97AEX_FATAL=" << error.what() << '\n';
    std::cout << "PATCH_POSTIMAGE_BYTES_PROVEN=UNKNOWN\n";
    std::cout << "INVARIANT_FINGERPRINT=UNKNOWN\n";
    std::cout << "BOUNDED_31_PROVENANCE=UNKNOWN\n";
    std::cout << "SOURCE_MUTATION=NO\n";
    std::cout << "SYSTEM_FILE_MUTATION=NO\n";
    std::cout << "GOLDEN_MUTATION=NO\n";
    std::cout << "TARGET_CODE_BYTES_MUTATION=NO\n";
    std::cout << "TARGET_PROCESS_CONTROL_MUTATION=NO\n";
    std::cout << "RUNTIME_INSTRUMENTATION=YES_APPLE_PRIVATE_TASK_READ_PORT\n";
    std::cout << "BRANCH_EXECUTION_CLAIM=NOT_MADE\n";
    std::cout << "SERVICE_LAUNCH=AUTO-NO\n";
    std::cout << "ROOT_PATCH=AUTO-NO\n";
    std::cout << "REBOOT=AUTO-NO\n";
    return 2;
  }
}
