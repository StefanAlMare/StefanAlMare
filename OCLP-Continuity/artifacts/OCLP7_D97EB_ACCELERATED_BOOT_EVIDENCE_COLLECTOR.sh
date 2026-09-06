#!/bin/bash
set -u

# OCLP7 D97EB — accelerated-boot evidence collector
# TARGET: ASUS2, currently booted in VESA recovery.
# READ-ONLY evidence collection.
# Exact accelerated diagnostic window:
#   2026-09-07 02:22:30 through 2026-09-07 02:24:59 EEST
# Current VESA boot at 02:25 is intentionally excluded.

START="2026-09-07 02:22:30"
END="2026-09-07 02:24:59"

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="$HOME/Desktop/OCLP7_D97EB_ACCEL_FAIL_${STAMP}"
ZIP="$HOME/Desktop/OCLP7_D97EB_ACCEL_FAIL_${STAMP}.zip"

mkdir -p "$OUT"
exec > >(tee "$OUT/COLLECTOR_CONSOLE.txt") 2>&1

echo "===== OCLP7 D97EB — ACCELERATED BOOT EVIDENCE ====="
echo "TARGET=ASUS2"
echo "CURRENT_MODE=VESA_RECOVERY"
echo "ACCEL_WINDOW_START=$START"
echo "ACCEL_WINDOW_END=$END"
echo "CURRENT_VESA_BOOT=2026-09-07 02:25"
echo "ROOT_MUTATION=NO"
echo "EFI_MUTATION=NO"
echo "REBOOT=NO"
echo

echo "==> Current system identity"
sw_vers > "$OUT/CURRENT_SW_VERS.txt" 2>&1 || true
/usr/sbin/nvram boot-args > "$OUT/CURRENT_BOOT_ARGS.txt" 2>&1 || true
last reboot | head -n 16 > "$OUT/REBOOT_CHRONOLOGY.txt" 2>&1 || true

echo "==> Current D97DL / D97BV state"
{
  /usr/bin/kmutil showloaded 2>/dev/null | grep -E 'OCLPMetalCompat|WhateverGreen|Lilu|AppleIntelFramebufferAzul|AppleIntelHD5000Graphics' || true
  echo
  /usr/sbin/ioreg -lw0 -p IOService | grep -E 'D97DI|D97DL|D97CT' || true
} > "$OUT/CURRENT_D97_RUNTIME.txt" 2>&1

echo "==> Current Root Patch metadata"
P="/System/Library/CoreServices/OpenCore-Legacy-Patcher.plist"
if [[ -f "$P" ]]; then
  /usr/bin/plutil -p "$P" > "$OUT/CURRENT_ROOT_PATCH_METADATA.txt" 2>&1 || true
else
  echo "MISSING" > "$OUT/CURRENT_ROOT_PATCH_METADATA.txt"
fi

echo "==> Read-only privileged log access"
if sudo -v; then
  echo "SUDO_GATE=PASS"
else
  echo "SUDO_GATE=FAIL"
fi

echo "==> Accelerated boot lifecycle log"
sudo /usr/bin/log show \
  --start "$START" --end "$END" \
  --style syslog --info --debug \
  --predicate '
      process == "launchd" OR
      process == "loginwindow" OR
      process == "WindowServer" OR
      process == "ReportCrash" OR
      process == "watchdogd" OR
      eventMessage CONTAINS[c] "shutdown" OR
      eventMessage CONTAINS[c] "reboot" OR
      eventMessage CONTAINS[c] "panic" OR
      eventMessage CONTAINS[c] "watchdog" OR
      eventMessage CONTAINS[c] "WindowServer" OR
      eventMessage CONTAINS[c] "loginwindow" OR
      eventMessage CONTAINS[c] "exited" OR
      eventMessage CONTAINS[c] "crash" OR
      eventMessage CONTAINS[c] "failed"
  ' > "$OUT/ACCEL_LIFECYCLE.log" 2>&1 || true

echo "==> Accelerated boot Metal/GPU log"
sudo /usr/bin/log show \
  --start "$START" --end "$END" \
  --style syslog --info --debug \
  --predicate '
      process == "MTLCompilerService" OR
      process == "WindowServer" OR
      process == "kernel" OR
      eventMessage CONTAINS[c] "MTLCompiler" OR
      eventMessage CONTAINS[c] "Metal" OR
      eventMessage CONTAINS[c] "MTL4" OR
      eventMessage CONTAINS[c] "IOGPU" OR
      eventMessage CONTAINS[c] "GPUCompiler" OR
      eventMessage CONTAINS[c] "AppleIntel" OR
      eventMessage CONTAINS[c] "Azul" OR
      eventMessage CONTAINS[c] "Framebuffer" OR
      eventMessage CONTAINS[c] "AGX"
  ' > "$OUT/ACCEL_METAL_GPU.log" 2>&1 || true

echo "==> Accelerated boot kernel/panic log"
sudo /usr/bin/log show \
  --start "$START" --end "$END" \
  --style syslog --info --debug \
  --predicate '
      process == "kernel" OR
      eventMessage CONTAINS[c] "panic" OR
      eventMessage CONTAINS[c] "Previous shutdown cause" OR
      eventMessage CONTAINS[c] "userspace reboot" OR
      eventMessage CONTAINS[c] "GPU Restart" OR
      eventMessage CONTAINS[c] "IOGPU" OR
      eventMessage CONTAINS[c] "hang" OR
      eventMessage CONTAINS[c] "stall"
  ' > "$OUT/ACCEL_KERNEL_PANIC.log" 2>&1 || true

echo "==> Power-management chronology"
{
  /usr/bin/pmset -g log 2>/dev/null | grep -E '2026-09-07 02:2[2-5]' || true
} > "$OUT/PMSET_WINDOW.txt" 2>&1

echo "==> Relevant crash reports"
CRASHDIR="$OUT/DiagnosticReports"
mkdir -p "$CRASHDIR"
MAN="$OUT/DIAGNOSTIC_REPORTS_MANIFEST.txt"
: > "$MAN"

copy_matching_reports() {
  local d="$1"
  [[ -d "$d" ]] || return 0
  local f b
  for f in "$d"/*; do
    [[ -f "$f" ]] || continue
    b="$(basename "$f")"
    case "$b" in
      *WindowServer*|*MTLCompilerService*|*loginwindow*|*GPU*|*IOGPU*|*panic*|*Panic*|*watchdog*|*Watchdog*)
        /usr/bin/stat -f '%Sm | %z bytes | %N' -t '%Y-%m-%d %H:%M:%S' "$f" >> "$MAN" 2>/dev/null || true
        /bin/cp -p "$f" "$CRASHDIR/" 2>/dev/null || true
        ;;
    esac
  done
}

copy_matching_reports "/Library/Logs/DiagnosticReports"
copy_matching_reports "$HOME/Library/Logs/DiagnosticReports"
copy_matching_reports "/Library/Logs/DiagnosticReports/Retired"

echo "==> Compact classifier extracts"
{
  echo "===== LIFECYCLE HITS ====="
  grep -Ei 'shutdown|reboot|panic|watchdog|WindowServer|loginwindow|exited|crash|failed|SIG|termination' "$OUT/ACCEL_LIFECYCLE.log" | tail -n 800 || true
  echo
  echo "===== METAL/GPU HITS ====="
  grep -Ei 'MTLCompiler|Metal|MTL4|IOGPU|GPUCompiler|AppleIntel|Azul|Framebuffer|fault|error|fail|abort|terminate' "$OUT/ACCEL_METAL_GPU.log" | tail -n 1200 || true
  echo
  echo "===== KERNEL/PANIC HITS ====="
  grep -Ei 'panic|watchdog|shutdown cause|userspace reboot|GPU Restart|IOGPU|hang|stall' "$OUT/ACCEL_KERNEL_PANIC.log" | tail -n 800 || true
} > "$OUT/ACCEL_COMPACT_EXTRACT.txt"

echo "==> File hashes"
(
  cd "$OUT" || exit 1
  find . -type f -maxdepth 2 -print0 | sort -z | xargs -0 shasum -a 256
) > "$OUT/MANIFEST_SHA256.txt" 2>&1 || true

echo "==> Package evidence"
rm -f "$ZIP"
/usr/bin/ditto -c -k --sequesterRsrc --keepParent "$OUT" "$ZIP"

ZIP_SHA="$(shasum -a 256 "$ZIP" | awk '{print $1}')"
ZIP_BYTES="$(stat -f '%z' "$ZIP")"

echo
echo "=============================================="
echo "D97EB_COLLECTION_STATUS=PASS"
echo "D97EB_ACCEL_WINDOW_START=$START"
echo "D97EB_ACCEL_WINDOW_END=$END"
echo "D97EB_CURRENT_VESA_BOOT_EXCLUDED=YES"
echo "ZIP=$ZIP"
echo "ZIP_BYTES=$ZIP_BYTES"
echo "ZIP_SHA256=$ZIP_SHA"
echo "ROOT_MUTATION=NO"
echo "EFI_MUTATION=NO"
echo "REBOOT=NO"
echo "=============================================="
