# Codebase Concerns

**Analysis Date:** 2026-05-24

## Tech Debt

**Monolithic Installation Scripts:**
- Issue: `libs/lib-install.sh` (1087 lines) and `libs/lib-core.sh` (814 lines) are extremely large and contain deeply nested procedural logic for system-wide configuration and dependency management.
- Files: `libs/lib-install.sh`, `libs/lib-core.sh`, `install.sh`, `tweaks.sh`
- Impact: Very difficult to maintain, test, or extend. High risk of side effects when modifying installer logic.
- Fix approach: Refactor into smaller, modular scripts focused on specific tasks (e.g., separate package management from file operations).

**Unresolved SASS/CSS Hacks:**
- Issue: Numerous `FIXME` and `HACK` comments in SASS files indicate workarounds for GTK bugs or incomplete theme assets.
- Files: `src/sass/gtk/_common-3.0.scss`, `src/sass/gtk/_common-4.0.scss`, `src/sass/gtk/apps/_gnome-3.22.scss`, `src/main/gtk-4.0/gtk-Dark.css`
- Impact: Visual inconsistencies across different GTK versions and missing UI elements (e.g., OSD and selected list rows mentioned in `_common-4.0.scss`).
- Fix approach: Systematically address `FIXME` items, especially those noting missing assets or "temporary" workarounds.

**Dangling TODOs:**
- Issue: Some scripts reference non-existent integrations or incomplete features.
- Files: `clean-git.sh` (Line 6: `TODO: integrate with Bridge.sh`), `libs/lib-core.sh` (Line 268: `TODO: return "lockWhiteSur()" back...`)
- Impact: Confusion for developers and potential dead code.
- Fix approach: Remove obsolete TODOs or implement the missing functionality.

## Security Considerations

**Excessive Sudo Usage:**
- Issue: The project relies heavily on `sudo` for many operations that might not strictly require it, or could be handled more safely.
- Files: `libs/lib-install.sh`, `libs/lib-core.sh`, `tweaks.sh`, `install.sh`
- Risk: Potential for system corruption if a bug exists in the scripts. Running arbitrary logic with root privileges.
- Current mitigation: Some checks to prevent running `--libadwaita` with sudo in `install.sh`.
- Recommendations: Implement a safer permission model; separate root operations from user-level configuration.

**Insecure Dependency Installation:**
- Issue: `clean-git.sh` attempts to `sudo pip install` a package.
- Files: `clean-git.sh`
- Risk: Installing Python packages as root is highly discouraged as it can break system-managed Python environments.
- Current mitigation: None.
- Recommendations: Use `pipx` or install to user directory.

**System Clock Manipulation:**
- Issue: `prepare_deps` in `libs/lib-install.sh` updates the system clock using `sudo date -s` based on UTC time fetched from a remote source.
- Files: `libs/lib-install.sh`
- Risk: If the remote source is compromised, the script can be used to set an incorrect system time, potentially breaking SSL/TLS and other security mechanisms.
- Current mitigation: None.
- Recommendations: Use system-standard NTP services instead of manual time setting.

## Fragile Areas

**Distro-Specific Logic Overload:**
- Issue: The codebase contains complex, branching logic to support a wide array of Linux distributions and package managers.
- Files: `libs/lib-install.sh`
- Why fragile: Maintaining compatibility with `apt`, `dnf`, `zypper`, `pacman`, `xbps`, `eopkg`, and `swupd` is error-prone and requires constant testing on multiple platforms.
- Safe modification: Encapsulate distro-specific operations into separate provider scripts.

**Hardcoded Version Detection:**
- Issue: GNOME version detection is based on hardcoded ranges and string parsing of `gnome-shell --version`.
- Files: `libs/lib-core.sh`
- Why fragile: Will likely break or default to incorrect versions when GNOME 49+ is released.
- Safe modification: Use more robust version comparison logic or dynamic feature detection.

**Hardcoded Application Paths:**
- Issue: Paths for Firefox, Librewolf, Floorp, and GNOME extensions are hardcoded for various installation methods (Flatpak, Snap, Home).
- Files: `libs/lib-core.sh`
- Why fragile: Changes in upstream packaging (e.g., Snap or Flatpak mount points) will break theme installation for those apps.
- Safe modification: Use variables or search for application profiles dynamically.

## Performance Bottlenecks

**Asset Rendering:**
- Problem: `src/assets/render-all-assets.sh` uses Inkscape and Optipng to render hundreds of assets sequentially.
- Files: `src/assets/render-all-assets.sh`
- Cause: Single-threaded rendering of a large volume of SVG assets.
- Improvement path: Parallelize rendering using `xargs -P` or a similar tool.

## Test Coverage Gaps

**Installer Logic:**
- What's not tested: The complex branching logic in `lib-install.sh` is entirely untested via automated means.
- Files: `libs/lib-install.sh`, `libs/lib-core.sh`
- Risk: Regressions in one distro's installation path might go unnoticed until reported by users.
- Priority: High

---

*Concerns audit: 2026-05-24*
