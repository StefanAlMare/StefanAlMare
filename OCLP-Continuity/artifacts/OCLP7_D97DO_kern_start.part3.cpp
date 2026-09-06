            );
            atomic_store_explicit(
                &d97doCavePropagationPid, currentPid, memory_order_relaxed
            );
            atomic_store_explicit(
                &d97doCavePropagationState, 1U, memory_order_release
            );
            recordPassOrFirstNegative(&d97diCaveMutationState, true);
        } else if (phaseBefore == 0U) {
            // Unexpected pre-existing postimage: do not claim authorship.
            recordPassOrFirstNegative(&d97diCaveMutationState, false);
            atomic_store_explicit(
                &d97doCavePropagationState, 2U, memory_order_release
            );
        }
        return;
    }

    if (phaseBefore == 2U) {
        // Classify propagation only on a different userspace PID from the writer.
        const int32_t writePid =
            atomic_load_explicit(&d97doCaveWritePid, memory_order_acquire);
        if (currentPid > 0 && writePid > 0 && currentPid != writePid) {
            atomic_store_explicit(
                &d97doCavePropagationPid, currentPid, memory_order_relaxed
            );
            if (fullCaveZero && functionalWindowZero) {
                atomic_fetch_add_explicit(
                    &d97doCaveZeroSeenAfterWrite, 1U, memory_order_relaxed
                );
            }
            atomic_store_explicit(
                &d97doCavePropagationState, 2U, memory_order_release
            );
        }
        return;
    }

    if (phaseBefore != 0U)
        return;

    if (currentPid <= 0)
        return;

    if (!fullCaveZero || !functionalWindowZero || !validationSafe) {
        recordPassOrFirstNegative(&d97diCaveMutationState, false);
        atomic_store_explicit(&d97doCaveWritePhase, 3U, memory_order_release);
        return;
    }

    uint32_t expectedPhase = 0U;
    if (!atomic_compare_exchange_strong_explicit(
            &d97doCaveWritePhase,
            &expectedPhase,
            1U,
            memory_order_acq_rel,
            memory_order_acquire
        )) {
        return;
    }

    atomic_store_explicit(
        &d97doCaveWritePid, currentPid, memory_order_relaxed
    );

    writeExact(
        mutablePage + CaveInPage,
        CaveReplacement,
        sizeof(CaveReplacement)
    );

    const bool cavePostimageMatch =
        !memcmp(page + CaveInPage, CaveReplacement, sizeof(CaveReplacement));
    const bool caveTailZeroAfter =
        allZero(
            page + CaveInPage + sizeof(CaveReplacement),
            CaveLength - sizeof(CaveReplacement)
        );

    atomic_store_explicit(
        &d97diCavePostimageState,
        cavePostimageMatch ? 1U : 2U,
        memory_order_relaxed
    );
    atomic_store_explicit(
        &d97diCaveTailZeroState,
        caveTailZeroAfter ? 1U : 2U,
        memory_order_relaxed
    );

    const bool writePass = cavePostimageMatch && caveTailZeroAfter;
    atomic_store_explicit(
        &d97diCaveMutationState,
        writePass ? 1U : 2U,
        memory_order_release
    );
    if (writePass) {
        atomic_fetch_add_explicit(&d97diCaveWriteCount, 1U, memory_order_relaxed);
        atomic_store_explicit(&d97doCaveWritePhase, 2U, memory_order_release);
    } else {
        atomic_store_explicit(&d97doCaveWritePhase, 3U, memory_order_release);
    }

}

static void pluginStart() {
    startPublisher();

    const bool argOk = checkKernelArgument("-ocmcdiag");
    atomic_store_explicit(&bootArgGate, argOk ? 1U : 2U, memory_order_relaxed);
    if (!argOk)
        return;

    const bool fullFunctionalArg = checkKernelArgument("-ocmcd97bv");
    const bool caveOnlyArg = checkKernelArgument("-ocmcd97bvcave");
    atomic_store_explicit(
        &d97doFullFunctionalArgPresent,
        fullFunctionalArg ? 1U : 0U,
        memory_order_relaxed
    );
    atomic_store_explicit(
        &d97doCaveOnlyRequested,
        (!fullFunctionalArg && caveOnlyArg) ? 1U : 0U,
        memory_order_relaxed
    );

    const bool kernelOk = getKernelVersion() == KernelVersion::Tahoe;
    atomic_store_explicit(&kernelGate, kernelOk ? 1U : 2U, memory_order_relaxed);
    if (!kernelOk)
        return;

    const bool cpuOk =
        BaseDeviceInfo::get().cpuGeneration == CPUInfo::CpuGeneration::Haswell;
    atomic_store_explicit(&cpuGate, cpuOk ? 1U : 2U, memory_order_relaxed);
    if (!cpuOk)
        return;

    lilu.onPatcherLoadForce([](void *user, KernelPatcher &patcher) {
        KernelPatcher::RouteRequest route(
            "_cs_validate_page",
            patchedCsValidatePage,
            orgCsValidatePage
        );

        const bool routed =
            patcher.routeMultipleLong(KernelPatcher::KernelID, &route, 1);

        atomic_store_explicit(&routeState, routed ? 1U : 2U, memory_order_relaxed);
    });
}

static const char *bootargOff[] {
    "-ocmcoff"
};

static const char *bootargDebug[] {
    "-ocmcdbg"
};

static const char *bootargBeta[] {
    "-ocmcbeta"
};

PluginConfiguration ADDPR(config) {
    xStringify(PRODUCT_NAME),
    parseModuleVersion(xStringify(MODULE_VERSION)),
    LiluAPI::AllowNormal,
    bootargOff,
    arrsize(bootargOff),
    bootargDebug,
    arrsize(bootargDebug),
    bootargBeta,
    arrsize(bootargBeta),
    KernelVersion::Tahoe,
    KernelVersion::Tahoe,
    pluginStart
};
