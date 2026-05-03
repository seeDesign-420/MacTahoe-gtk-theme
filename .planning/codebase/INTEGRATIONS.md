# External Integrations

**Analysis Date:** 2025-02-12

## APIs & External Services

**Issue Tracking:**
- **GitHub** - Used for issue reporting and project hosting.
  - Link: `https://github.com/vinceliuice/MacTahoe-gtk-theme/issues`

**Time Synchronization:**
- **iana.org** - Used for fetching UTC time via `/dev/tcp/iana.org/80` to verify and fix system clock if needed (`libs/lib-core.sh`).

## Data Storage

**Databases:**
- **dconf** - Used via `dbus-launch` to write configuration for GNOME Shell extensions (Dash to Dock, Blur my Shell).

**File Storage:**
- **Local Filesystem** - Primary storage for theme files.
  - System themes: `/usr/share/themes`
  - User themes: `~/.themes`
  - GDM themes: `/usr/share/gnome-shell/theme`
  - Application configs: `~/.mozilla/firefox`, `~/.config/gtk-4.0`

**Caching:**
- **XDG Cache** - Used for temporary Flatpak build artifacts (`~/.cache/pakitheme`).

## Authentication & Identity

**Auth Provider:**
- **System Sudo** - Used for elevated permissions during installation and configuration of system-wide themes.

## Monitoring & Observability

**Error Tracking:**
- **Local Error Logs** - Custom error logging mechanism in `libs/lib-core.sh` that captures `ERR` signals and writes to `/tmp/MacTahoe.lock/error_log.txt`.

**Logs:**
- **Standard Output/Error** - Shell scripts use custom `prompt` function for colored console output.

## CI/CD & Deployment

**Hosting:**
- **GitHub** - Source code repository.

**CI Pipeline:**
- **Not detected** - No automated CI configuration (e.g., GitHub Actions) found in the root.

## Environment Configuration

**Required env vars:**
- `REPO_DIR`: Root directory of the repository.
- `USER` / `SUDO_USER`: Used to determine home directory and ownership.

**Secrets location:**
- Not applicable (no external API keys or secrets detected).

## Webhooks & Callbacks

**Incoming:**
- None

**Outgoing:**
- None

## System Integrations

**Desktop Environments:**
- **GNOME Shell:** Integration via CSS themes, GResource files, and GDM configuration.
- **Cinnamon:** Support via dedicated CSS and asset bundles.
- **XFCE:** Integration with XFWM4 and Whisker Menu.
- **Metacity:** Window manager support.

**Application Integration:**
- **Firefox / Librewolf / Floorp:** Custom CSS injection via `userChrome.css` and `userContent.css`.
- **Flatpak:** Theme conversion to Flatpak runtime bundles using `ostree` and `flatpak build-bundle`.
- **Plank:** Dock theme integration.
- **Dash to Dock / Blur my Shell:** Extension-specific CSS and dconf configuration.

---

*Integration audit: 2025-02-12*
