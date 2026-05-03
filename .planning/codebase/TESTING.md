# Testing Patterns

**Analysis Date:** 2025-02-11

## Test Framework

**Runner:**
- No automated test runner (e.g., Bats, ShellSpec) is currently used.

**Assertion Library:**
- Manual checks using shell conditionals (e.g., `[[ -f "${FILE}" ]]`, `has_command`).

**Run Commands:**
```bash
./install.sh           # Manual installation test
./make-release.sh      # Build-time verification and packaging
./parse-sass.sh        # Verify SASS compilation
```

## Test File Organization

**Location:**
- No dedicated test directory.

**Naming:**
- Not applicable.

## Test Structure

**Suite Organization:**
Testing is performed manually by running the installation scripts on different distributions or desktop environments.

**Patterns:**
- **Dependency Validation:** Scripts check for required tools (`sassc`, `inkscape`, `optipng`, `glib-compile-resources`, `xmllint`) before proceeding.
- **Environment Checks:** Scripts detect the OS (Debian, Arch, Fedora, etc.) and Desktop Environment (GNOME, Cinnamon, XFCE) to apply correct settings.
- **Visual Inspection:** Release includes screenshots (`screenshot01.jpeg`) to serve as a baseline for visual correctness.

## Mocking

**Framework:** Not used.

**Patterns:**
- Real system calls are used. The script uses a lock directory `/tmp/MacTahoe.lock` to simulate a "session" and capture real error output.

## Fixtures and Factories

**Test Data:**
- Sample configurations for Firefox, GDM, and Dash-to-Dock are stored in `other/`.

**Location:**
- `other/firefox/`
- `other/gdm/`
- `other/dash-to-dock/`

## Coverage

**Requirements:** None enforced.

## Test Types

**Unit Tests:**
- Not used. Logic is tested through end-to-end execution of installation scripts.

**Integration Tests:**
- Manual verification of theme application across different GTK versions (GTK 2, 3, 4) and Shell versions.

**E2E Tests:**
- Manual execution of `install.sh` with various flags (e.g., `./install.sh -t blue -s nord`).

## Common Patterns

**Async Testing:**
- The `remove_themes` function in `libs/lib-install.sh` uses background processes (`&`) and `wait` for parallel cleanup, but this is for performance, not testing.

**Error Testing:**
- The script intentionally captures standard error into a log file:
  `exec 2> "${MACTAHOE_TMP_DIR}/error_log.txt"`
- This log is displayed by `signal_error` when a command fails.

---

*Testing analysis: 2025-02-11*
