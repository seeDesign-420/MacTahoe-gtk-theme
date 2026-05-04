# External Integrations

**Analysis Date:** 2026-05-24

## APIs & External Services

**Desktop Environments:**
- GNOME Shell - Integration via custom themes and CSS overrides. Support for versions 3.28 to 48+.
- Cinnamon - Theme integration via `src/main/cinnamon/`.
- XFCE - Window manager integration via XFWM4 themes in `src/main/xfwm4/`.

**Applications:**
- Firefox - Custom styling via `userChrome.css` and `userContent.css` in `other/firefox/`.
- Plank - Dock styling in `other/plank/`.
- Dash-to-Dock - Specific extension styling in `other/dash-to-dock/`.

## Data Storage

**Databases:**
- Not applicable (File-based theme distribution)

**File Storage:**
- Local filesystem only. Themes are installed to `/usr/share/themes` (system) or `~/.themes` (user).
- Libadwaita integration writes to `~/.config/gtk-4.0/`.

**Caching:**
- Temporary directory `/tmp/MacTahoe.lock` used during installation for lock files and error logs.

## Authentication & Identity

**Auth Provider:**
- System Sudo - Used for system-wide installation and modifying restricted files (GDM themes, Flatpak system runtimes).

## Monitoring & Observability

**Error Tracking:**
- Local log file: `${MACTAHOE_TMP_DIR}/error_log.txt` (typically `/tmp/MacTahoe.lock/error_log.txt`) captured during script execution.

**Logs:**
- Console output with color-coded prompts (`libs/lib-core.sh`'s `prompt` function).

## CI/CD & Deployment

**Hosting:**
- GitHub - Source control and issue tracking.

**CI Pipeline:**
- Manual Release - `make-release.sh` script automates the creation of `.tar.xz` archives for different color and opacity variants.

## Environment Configuration

**Required env vars:**
- `XDG_SESSION_TYPE` - Checked by Fildem to ensure GDK backend compatibility.
- `USER` / `SUDO_USER` - Used to determine the target home directory for local installations.

**Secrets location:**
- Not applicable (No secrets stored)

## Webhooks & Callbacks

**Incoming:**
- None

**Outgoing:**
- None

## Integration Points

**Flatpak:**
- Theme injection into Flatpak applications using `ostree` and `flatpak build-bundle`. Handled by `libs/lib-flatpak.sh`.

**GDM (GNOME Display Manager):**
- Integration via GResource replacement. `other/gdm/install.sh` handles backup and replacement of `gnome-shell-theme.gresource`.

**Fildem Global Menu:**
- Integration between a Python HUD/Global Menu service and a GNOME Shell extension. Located in `Fildem-Gnome-45/`.

**Libadwaita:**
- Integration via CSS overrides in `~/.config/gtk-4.0/`, enabling theme support for modern GTK 4 applications.

---

*Integration audit: 2026-05-24*
