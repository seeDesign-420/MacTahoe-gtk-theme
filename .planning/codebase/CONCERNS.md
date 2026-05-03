# Codebase Concerns

**Analysis Date:** 2025-05-03

## Tech Debt

**SASS Complexity and FIXMEs:**
- Issue: The core SASS files for GTK 3 and 4 are extremely large and contain numerous `FIXME`, `HACK`, and `TODO` comments indicating incomplete styling or workarounds for upstream issues.
- Files: `src/sass/gtk/_common-3.0.scss`, `src/sass/gtk/_common-4.0.scss`, `src/sass/gtk/apps/_gnome-3.22.scss`
- Impact: Difficult to maintain and update the theme for new GTK versions; potential for visual regressions.
- Fix approach: Refactor large SASS files into smaller, component-based modules and address long-standing `FIXME` items.

**Monolithic Installation Scripts:**
- Issue: `libs/lib-install.sh` and `libs/lib-core.sh` are very large (47KB and 25KB respectively) and contain complex logic for multi-distro support, dependency management, and theme installation.
- Files: `libs/lib-install.sh`, `libs/lib-core.sh`
- Impact: High risk of bugs when adding support for new distributions or modifying installation logic. Hard to debug.
- Fix approach: Break down installation logic into distro-specific modules or use a more robust automation tool.

**In-place Release Building:**
- Issue: `make-release.sh` installs themes directly to the developer's system before compressing them for release.
- Files: `make-release.sh`
- Impact: Pollutes the developer's environment and risks releasing local configurations/modifications.
- Fix approach: Use a temporary build directory (sandbox) for creating release packages.

## Security Considerations

**Aggressive Sudo Usage:**
- Risk: Extensive use of `sudo` for operations like `rm -rf`, `mv`, and package installation. The `sudo` command itself is overridden with a custom function.
- Files: `libs/lib-core.sh`, `libs/lib-install.sh`, `parse-sass.sh`
- Current mitigation: Minimal; scripts prompt for password when needed.
- Recommendations: Avoid overriding `sudo`. Use more granular permissions and avoid system-wide modifications where possible (e.g., install to `~/.local/share/themes` instead of `/usr/share/themes`).

**System File Modification:**
- Risk: The script aggressively modifies `/etc/os-release` on Clear Linux to fix `swupd` issues.
- Files: `libs/lib-install.sh`
- Current mitigation: None.
- Recommendations: Avoid modifying critical system files; use less invasive methods to detect or fix package manager issues.

**Forced System Clock Synchronization:**
- Risk: The installer forces a system clock update by connecting to `iana.org` over plain HTTP (port 80).
- Files: `libs/lib-core.sh` (function `get_utc_epoch_time`), `libs/lib-install.sh` (function `prepare_deps`)
- Current mitigation: None.
- Recommendations: Use standard NTP services if necessary, or better, do not force clock updates as a side effect of installing a theme.

## Performance Bottlenecks

**Network Dependency during Installation:**
- Problem: The installation process blocks on a network request to `iana.org` for time synchronization.
- Files: `libs/lib-core.sh`, `libs/lib-install.sh`
- Cause: `prepare_deps` calls `get_utc_epoch_time` which uses `/dev/tcp/iana.org/80`.
- Improvement path: Make this check optional or remove it; users should manage their own system clock.

**Large CSS Assets:**
- Problem: The generated CSS files are quite large due to the complexity of the theme.
- Files: `src/main/gtk-3.0/gtk.css`, `src/main/gtk-4.0/gtk.css`
- Cause: Deeply nested SASS and extensive styling for many applications.
- Improvement path: Optimize SASS/CSS to reduce redundancy and file size.

## Fragile Areas

**Distro-Specific Patches:**
- Files: `libs/lib-install.sh`
- Why fragile: Contains many hardcoded logic paths for different distributions (Ubuntu, Fedora, Clear Linux, Arch, etc.). Small changes in these distros' package managers or file structures can break the installer.
- Safe modification: Thoroughly test on multiple distributions after any change to `lib-install.sh`.
- Test coverage: Gaps in automated testing for multi-distro installation.

**Hardcoded Application Paths:**
- Files: `libs/lib-core.sh`
- Why fragile: Hardcoded paths for Firefox, Librewolf, and Floorp profiles (including Flatpak and Snap versions).
- Safe modification: Check if these paths are still valid when these applications update their structure.
- Test coverage: None.

**Shell Version Detection:**
- Files: `libs/lib-core.sh`
- Why fragile: Relies on parsing `gnome-shell --version` output, which may vary across distributions or future versions.
- Safe modification: Ensure the parsing logic is robust against different version string formats.

## Missing Critical Features

**Automated Testing:**
- Problem: Lack of automated tests for the installation scripts and the visual integrity of the theme across different GTK versions.
- Blocks: Safe refactoring and reliable multi-distro support.

---

*Concerns audit: 2025-05-03*
