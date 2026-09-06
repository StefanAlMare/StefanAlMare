                                 atomic_load_explicit(&d97doCavePostimageSeenAfterWrite, memory_order_relaxed)
                             ), 32);
        service->setProperty("D97DOCaveZeroSeenAfterWrite",
                             static_cast<unsigned long long>(
                                 atomic_load_explicit(&d97doCaveZeroSeenAfterWrite, memory_order_relaxed)
                             ), 32);
        service->setProperty("D97DOCaveWritePid",
                             static_cast<unsigned long long>(
                                 static_cast<uint32_t>(
                                     atomic_load_explicit(&d97doCaveWritePid, memory_order_relaxed)
                                 )
                             ), 32);
        service->setProperty("D97DOCavePropagationPid",
                             static_cast<unsigned long long>(
                                 static_cast<uint32_t>(
                                     atomic_load_explicit(&d97doCavePropagationPid, memory_order_relaxed)
                                 )
                             ), 32);

        service->setProperty("D97DISiteSafety",
                             statusString(atomic_load_explicit(&d97diSiteSafetyState, memory_order_relaxed)));
        service->setProperty("D97DISiteMutation",
                             statusString(atomic_load_explicit(&d97diSiteMutationState, memory_order_relaxed)));
        service->setProperty("D97DISitePostimage",
                             statusString(atomic_load_explicit(&d97diSitePostimageState, memory_order_relaxed)));
        service->setProperty("D97DISiteWriteCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97diSiteWriteCount, memory_order_relaxed)), 32);

        service->setProperty("D97DICaveSafety",
                             statusString(atomic_load_explicit(&d97diCaveSafetyState, memory_order_relaxed)));
        service->setProperty("D97DICaveMutation",
                             statusString(atomic_load_explicit(&d97diCaveMutationState, memory_order_relaxed)));
        service->setProperty("D97DICavePostimage",
                             statusString(atomic_load_explicit(&d97diCavePostimageState, memory_order_relaxed)));
        service->setProperty("D97DICaveTailZeroAfter",
                             statusString(atomic_load_explicit(&d97diCaveTailZeroState, memory_order_relaxed)));
        service->setProperty("D97DICaveWriteCount",
                             static_cast<unsigned long long>(atomic_load_explicit(&d97diCaveWriteCount, memory_order_relaxed)), 32);

        service->setProperty("D97CTBootArgGate",
                             static_cast<unsigned long long>(atomic_load_explicit(&bootArgGate, memory_order_relaxed)), 32);
        service->setProperty("D97CTKernelGate",
                             static_cast<unsigned long long>(atomic_load_explicit(&kernelGate, memory_order_relaxed)), 32);
        service->setProperty("D97CTBuildGate",
                             static_cast<unsigned long long>(atomic_load_explicit(&buildGate, memory_order_relaxed)), 32);
        service->setProperty("D97CTCpuGate",
                             static_cast<unsigned long long>(atomic_load_explicit(&cpuGate, memory_order_relaxed)), 32);

        const uint32_t route = atomic_load_explicit(&routeState, memory_order_relaxed);
        service->setProperty("D97CTRouteStatus", statusString(route));

        const uint32_t siteCount = atomic_load_explicit(&siteSeenCount, memory_order_relaxed);
        service->setProperty("D97CTSiteSeenCount",
                             static_cast<unsigned long long>(siteCount), 32);
        if (siteCount > 0) {
            service->setProperty("D97CTSitePreimage",
                                 statusString(atomic_load_explicit(&sitePreimageState, memory_order_relaxed)));
            service->setProperty("D97CTSiteValidated",
                                 static_cast<unsigned long long>(atomic_load_explicit(&siteValidated, memory_order_relaxed)), 32);
            service->setProperty("D97CTSiteTainted",
                                 static_cast<unsigned long long>(atomic_load_explicit(&siteTainted, memory_order_relaxed)), 32);
            service->setProperty("D97CTSiteNX",
                                 static_cast<unsigned long long>(atomic_load_explicit(&siteNx, memory_order_relaxed)), 32);
        }

        const uint32_t caveCount = atomic_load_explicit(&caveSeenCount, memory_order_relaxed);
        service->setProperty("D97CTCaveSeenCount",
                             static_cast<unsigned long long>(caveCount), 32);
        if (caveCount > 0) {
            service->setProperty("D97CTCaveWindow18",
                                 statusString(atomic_load_explicit(&caveWindow18State, memory_order_relaxed)));
            service->setProperty("D97CTCaveFull208",
                                 statusString(atomic_load_explicit(&caveFull208State, memory_order_relaxed)));
            service->setProperty("D97CTCaveValidated",
                                 static_cast<unsigned long long>(atomic_load_explicit(&caveValidated, memory_order_relaxed)), 32);
            service->setProperty("D97CTCaveTainted",
                                 static_cast<unsigned long long>(atomic_load_explicit(&caveTainted, memory_order_relaxed)), 32);
            service->setProperty("D97CTCaveNX",
                                 static_cast<unsigned long long>(atomic_load_explicit(&caveNx, memory_order_relaxed)), 32);
        }

        service->setProperty("D97CTPublisherTicks",
                             static_cast<unsigned long long>(ticks), 32);
    }

    const bool caveOnlyRequested =
        atomic_load_explicit(&d97doCaveOnlyRequested, memory_order_relaxed) != 0;
    const bool caveWriteResolved =
        atomic_load_explicit(&d97doCaveWritePhase, memory_order_acquire) >= 2U;
    const bool propagationResolved =
        atomic_load_explicit(&d97doCavePropagationState, memory_order_acquire) != 0;
    const bool complete =
        caveOnlyRequested
            ? (caveWriteResolved && propagationResolved)
            : (atomic_load_explicit(&caveSeenCount, memory_order_relaxed) > 0);

    // Bounded 5-minute early-boot publication window.
    if (!complete && ticks < 300 && publisherCall) {
        uint64_t intervalAbs = 0;
        nanoseconds_to_absolutetime(1000000000ULL, &intervalAbs);
        thread_call_enter_delayed(publisherCall, mach_absolute_time() + intervalAbs);
    }
}

static void startPublisher() {
    publisherCall = thread_call_allocate(publishState, nullptr);
    if (!publisherCall)
        return;

    uint64_t intervalAbs = 0;
    nanoseconds_to_absolutetime(1000000000ULL, &intervalAbs);
    thread_call_enter_delayed(publisherCall, mach_absolute_time() + intervalAbs);
}

static void patchedCsValidatePage(
    vnode_t vp,
    memory_object_t pager,
    memory_object_offset_t pageOffset,
    const void *data,
    int *validatedP,
    int *taintedP,
    int *nxP
) {
    FunctionCast(patchedCsValidatePage, orgCsValidatePage)(
        vp, pager, pageOffset, data, validatedP, taintedP, nxP
    );

    atomic_fetch_add_explicit(&d97ddCallbackSeenCount, 1, memory_order_relaxed);

    const bool buildOk = targetBuildMatches();
    atomic_store_explicit(&buildGate, buildOk ? 1U : 2U, memory_order_relaxed);
    if (!buildOk)
        return;

    if (pageOffset != SitePageOffset && pageOffset != CavePageOffset)
        return;

    if (!data)
        return;

    char path[PATH_MAX] {};
    int pathLen = PATH_MAX;
    if (vn_getpath(vp, path, &pathLen) != 0)
        return;

    if (!targetMainCachePath(path))
        return;

    const auto page = static_cast<const uint8_t *>(data);
    auto mutablePage = const_cast<uint8_t *>(page);

    const uint32_t validated = validatedP ? static_cast<uint32_t>(*validatedP) : 0;
    const uint32_t tainted = taintedP ? static_cast<uint32_t>(*taintedP) : 0;
    const uint32_t nx = nxP ? static_cast<uint32_t>(*nxP) : 0;
    const bool validationSafe = appleValidationSafe(validatedP, taintedP, nxP);
    const bool caveOnlyRequested =
        atomic_load_explicit(&d97doCaveOnlyRequested, memory_order_relaxed) != 0;
    const int32_t currentPid = static_cast<int32_t>(proc_selfpid());

    if (pageOffset == SitePageOffset) {
        const bool preimageMatch =
            !memcmp(page + SiteInPage, SitePreimage, sizeof(SitePreimage));

        const uint32_t priorSeen =
            atomic_fetch_add_explicit(&siteSeenCount, 1, memory_order_relaxed);
        if (priorSeen == 0) {
            atomic_store_explicit(&sitePreimageState, preimageMatch ? 1U : 2U, memory_order_relaxed);
            atomic_store_explicit(&siteValidated, validated, memory_order_relaxed);
            atomic_store_explicit(&siteTainted, tainted, memory_order_relaxed);
            atomic_store_explicit(&siteNx, nx, memory_order_relaxed);
        }

        recordPassOrFirstNegative(&d97diSiteSafetyState, validationSafe);

        // D97DO is deliberately CAVE-only. SITE mutation capability is absent
        // from the binary regardless of boot arguments.
        atomic_store_explicit(&d97doSiteWriteBlockedState, 1U, memory_order_relaxed);
        atomic_store_explicit(&d97diSiteMutationState, 4U, memory_order_relaxed);
        return;
    }

    const bool fullCaveZero = allZero(page + CaveInPage, CaveLength);
    const bool functionalWindowZero =
        allZero(page + CaveInPage, CaveFunctionalWindowLength);
    const bool cavePostimageAlready =
        !memcmp(page + CaveInPage, CaveReplacement, sizeof(CaveReplacement));
    const bool caveTailZero =
        allZero(
            page + CaveInPage + sizeof(CaveReplacement),
            CaveLength - sizeof(CaveReplacement)
        );

    const uint32_t priorSeen =
        atomic_fetch_add_explicit(&caveSeenCount, 1, memory_order_relaxed);
    if (priorSeen == 0) {
        atomic_store_explicit(&caveWindow18State, functionalWindowZero ? 1U : 2U, memory_order_relaxed);
        atomic_store_explicit(&caveFull208State, fullCaveZero ? 1U : 2U, memory_order_relaxed);
        atomic_store_explicit(&caveValidated, validated, memory_order_relaxed);
        atomic_store_explicit(&caveTainted, tainted, memory_order_relaxed);
        atomic_store_explicit(&caveNx, nx, memory_order_relaxed);
    }

    recordPassOrFirstNegative(&d97diCaveSafetyState, validationSafe);

    if (!caveOnlyRequested)
        return;

    const uint32_t phaseBefore =
        atomic_load_explicit(&d97doCaveWritePhase, memory_order_acquire);

    if (cavePostimageAlready && caveTailZero) {
        atomic_store_explicit(&d97diCavePostimageState, 1U, memory_order_relaxed);
        atomic_store_explicit(&d97diCaveTailZeroState, 1U, memory_order_relaxed);

        const int32_t writePid =
            atomic_load_explicit(&d97doCaveWritePid, memory_order_acquire);
        if (phaseBefore == 2U && validationSafe &&
            currentPid > 0 && writePid > 0 && currentPid != writePid) {
            atomic_fetch_add_explicit(
                &d97doCavePostimageSeenAfterWrite, 1U, memory_order_relaxed
