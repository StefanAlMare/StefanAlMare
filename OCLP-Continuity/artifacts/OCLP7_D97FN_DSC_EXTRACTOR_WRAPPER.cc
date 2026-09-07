#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>

using ExtractDylibsProgressT = int (*)(const char* shared_cache_file_path,
                                      const char* extraction_root_path,
                                      void (^progress)(unsigned current, unsigned total));

int main(int argc, const char* argv[]) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s <path-to-cache-file> <extraction-root>\n", argv[0]);
        return EXIT_FAILURE;
    }

    const char* bundle_path = "/usr/lib/dsc_extractor.bundle";
    void* handle = dlopen(bundle_path, RTLD_LAZY | RTLD_LOCAL);
    if (handle == nullptr) {
        fprintf(stderr, "D97FN_DLOPEN_FAIL=%s\n", dlerror());
        return EXIT_FAILURE;
    }

    dlerror();
    auto* extract = reinterpret_cast<ExtractDylibsProgressT>(
        dlsym(handle, "dyld_shared_cache_extract_dylibs_progress"));
    const char* sym_error = dlerror();
    if (sym_error != nullptr || extract == nullptr) {
        fprintf(stderr, "D97FN_DLSYM_FAIL=%s\n", sym_error ? sym_error : "symbol_not_found");
        dlclose(handle);
        return EXIT_FAILURE;
    }

    fprintf(stdout, "D97FN_BUNDLE=%s\n", bundle_path);
    fprintf(stdout, "D97FN_CACHE=%s\n", argv[1]);
    fprintf(stdout, "D97FN_OUTPUT=%s\n", argv[2]);
    fflush(stdout);

    __block unsigned last_printed = 0;
    int result = (*extract)(argv[1], argv[2], ^(unsigned current, unsigned total) {
        if (current == 0 || current == total || current >= last_printed + 100) {
            fprintf(stdout, "D97FN_PROGRESS=%u/%u\n", current, total);
            fflush(stdout);
            last_printed = current;
        }
    });

    fprintf(stdout, "D97FN_EXTRACT_RESULT=%d\n", result);
    fflush(stdout);
    dlclose(handle);
    return (result == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}
