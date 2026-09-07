#!/bin/bash
set -euo pipefail

LABEL="com.oclp.d97ew.capture"
BASE="/Users/Shared/OCLP-D97EW-Capture"
SUPPORT="/Library/Application Support/OCLP-D97EW"
CAPTURE="$SUPPORT/d97ew-capture.sh"
PLIST="/Library/LaunchDaemons/${LABEL}.plist"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "D97EW_INSTALL_FAIL=NOT_DARWIN" >&2
  exit 1
fi

if [[ "${EUID}" -ne 0 ]]; then
  echo "D97EW_INSTALL_FAIL=RUN_WITH_SUDO" >&2
  exit 1
fi

if [[ "${1:-}" == "--uninstall" ]]; then
  /bin/launchctl bootout "system/${LABEL}" 2>/dev/null || true
  /bin/rm -f "$PLIST" "$CAPTURE"
  /usr/bin/rmdir "$SUPPORT" 2>/dev/null || true
  echo "D97EW_UNINSTALL_STATUS=PASS"
  echo "D97EW_LOGS_PRESERVED=$BASE"
  exit 0
fi

/bin/mkdir -p "$BASE" "$SUPPORT"
/usr/sbin/chown root:wheel "$SUPPORT"
/bin/chmod 0755 "$SUPPORT"
/usr/sbin/chown root:wheel "$BASE"
/bin/chmod 0755 "$BASE"

cat > "$CAPTURE" <<'CAPTURE_EOF'
#!/bin/bash
set -u

BASE="/Users/Shared/OCLP-D97EW-Capture"
RUN_ID="$(/bin/date -u '+%Y%m%dT%H%M%SZ')-$$"
RUN_DIR="$BASE/$RUN_ID"
/bin/mkdir -p "$RUN_DIR"
/usr/sbin/chown root:wheel "$RUN_DIR"
/bin/chmod 0755 "$RUN_DIR"

exec >> "$RUN_DIR/collector.log" 2>&1

echo "D97EW_CAPTURE_START_UTC=$(/bin/date -u '+%Y-%m-%dT%H:%M:%SZ')"
echo "D97EW_CAPTURE_PID=$$"
echo "D97EW_CAPTURE_RUN_DIR=$RUN_DIR"

/usr/bin/sw_vers > "$RUN_DIR/sw_vers.txt" 2>&1 || true
/usr/bin/uname -a > "$RUN_DIR/uname.txt" 2>&1 || true
/usr/sbin/nvram boot-args > "$RUN_DIR/boot_args.txt" 2>&1 || true
/usr/bin/kmutil showloaded > "$RUN_DIR/kmutil_showloaded.txt" 2>&1 || true
/usr/bin/grep -Ei 'OCLPMetalCompat|oclpmetalcompat' "$RUN_DIR/kmutil_showloaded.txt" > "$RUN_DIR/oclpmetalcompat_loaded.txt" 2>/dev/null || true

printf 'tick\tutc\tservice\tcaptured_count\tset_id_mode_calls\troute\n' > "$RUN_DIR/summary.tsv"

captured="0"
i=1
while [[ "$i" -le 300 ]]; do
  utc="$(/bin/date -u '+%Y-%m-%dT%H:%M:%SZ')"
  snap="$RUN_DIR/ioreg_$(printf '%03d' "$i").txt"
  /usr/sbin/ioreg -r -c OCLPMetalCompat -l -w0 > "$snap" 2>&1 || true

  if /usr/bin/grep -q 'OCLPMetalCompat' "$snap"; then
    service="present"
    captured="$(/usr/bin/grep -E '"D97ESCapturedCount" = [0-9]+' "$snap" | /usr/bin/tail -n 1 | /usr/bin/sed -E 's/.*= ([0-9]+).*/\1/' || true)"
    calls="$(/usr/bin/grep -E '"D97ELSetIdModeCallCount" = [0-9]+' "$snap" | /usr/bin/tail -n 1 | /usr/bin/sed -E 's/.*= ([0-9]+).*/\1/' || true)"
    route="$(/usr/bin/grep -E '"D97ELRouteStatus" = ' "$snap" | /usr/bin/tail -n 1 | /usr/bin/sed -E 's/.*= "([^"]+)".*/\1/' || true)"
    [[ -n "$captured" ]] || captured="NA"
    [[ -n "$calls" ]] || calls="NA"
    [[ -n "$route" ]] || route="NA"
  else
    service="absent"
    captured="NA"
    calls="NA"
    route="NA"
  fi

  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$i" "$utc" "$service" "$captured" "$calls" "$route" >> "$RUN_DIR/summary.tsv"

  if [[ "$captured" =~ ^[0-9]+$ ]] && (( captured > 0 )); then
    /bin/cp "$snap" "$RUN_DIR/TUPLE_CAPTURE_FIRST.txt"
    /usr/sbin/nvram boot-args > "$RUN_DIR/TUPLE_CAPTURE_BOOT_ARGS.txt" 2>&1 || true
    /usr/bin/kmutil showloaded > "$RUN_DIR/TUPLE_CAPTURE_KMUTIL.txt" 2>&1 || true
    /bin/sync
    echo "D97EW_TUPLE_CAPTURED_AT_TICK=$i"
    echo "D97EW_TUPLE_CAPTURED_COUNT=$captured"

    j=1
    while [[ "$j" -le 5 ]]; do
      /bin/sleep 1
      /usr/sbin/ioreg -r -c OCLPMetalCompat -l -w0 > "$RUN_DIR/TUPLE_CAPTURE_POST_${j}.txt" 2>&1 || true
      /bin/sync
      j=$((j + 1))
    done
    echo "D97EW_CAPTURE_STATUS=TUPLE_CAPTURED"
    echo "D97EW_CAPTURE_END_UTC=$(/bin/date -u '+%Y-%m-%dT%H:%M:%SZ')"
    exit 0
  fi

  if (( i == 1 || i % 10 == 0 )); then
    /bin/sync
  fi

  /bin/sleep 1
  i=$((i + 1))
done

/bin/sync
echo "D97EW_CAPTURE_STATUS=TIMEOUT_NO_TUPLE"
echo "D97EW_CAPTURE_END_UTC=$(/bin/date -u '+%Y-%m-%dT%H:%M:%SZ')"
exit 0
CAPTURE_EOF

/usr/sbin/chown root:wheel "$CAPTURE"
/bin/chmod 0755 "$CAPTURE"

cat > "$PLIST" <<PLIST_EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>${LABEL}</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>${CAPTURE}</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <key>ProcessType</key>
  <string>Background</string>
  <key>StandardOutPath</key>
  <string>${BASE}/launchd.stdout.log</string>
  <key>StandardErrorPath</key>
  <string>${BASE}/launchd.stderr.log</string>
</dict>
</plist>
PLIST_EOF

/usr/sbin/chown root:wheel "$PLIST"
/bin/chmod 0644 "$PLIST"
/usr/bin/plutil -lint "$PLIST"

/bin/launchctl bootout "system/${LABEL}" 2>/dev/null || true
/bin/launchctl bootstrap system "$PLIST"
/bin/launchctl kickstart -k "system/${LABEL}"

CAPTURE_SHA256="$(/usr/bin/shasum -a 256 "$CAPTURE" | /usr/bin/awk '{print $1}')"
PLIST_SHA256="$(/usr/bin/shasum -a 256 "$PLIST" | /usr/bin/awk '{print $1}')"

echo "D97EW_INSTALL_STATUS=PASS"
echo "D97EW_CAPTURE_PATH=$CAPTURE"
echo "D97EW_CAPTURE_SHA256=$CAPTURE_SHA256"
echo "D97EW_PLIST_PATH=$PLIST"
echo "D97EW_PLIST_SHA256=$PLIST_SHA256"
echo "D97EW_OUTPUT_BASE=$BASE"
echo "D97EW_LAUNCHD_LABEL=$LABEL"
echo "D97EW_REBOOT_PERFORMED=NO"
echo "D97EW_EFI_MUTATION=NO"
echo "D97EW_ROOT_PATCH=NO"

/bin/sleep 3
LATEST="$(/bin/ls -1dt "$BASE"/20* 2>/dev/null | /usr/bin/head -n 1 || true)"
if [[ -n "$LATEST" ]]; then
  echo "D97EW_LIVE_TEST_RUN=$LATEST"
  /usr/bin/tail -n 5 "$LATEST/summary.tsv" 2>/dev/null || true
fi
