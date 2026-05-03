# Technology Stack

**Analysis Date:** 2025-02-12

## Languages

**Primary:**
- **Bash:** 4.0+ - Used for all installation, configuration, and build scripts (`install.sh`, `tweaks.sh`, `parse-sass.sh`, `make-release.sh`).
- **SCSS/SASS:** Used for theme styling across different desktop environments and GTK versions (`src/sass/`, `other/gdm/gnome-shell-sass/`).

**Secondary:**
- **CSS:** Generated from SCSS, used for final theme files and application-specific styles (Firefox, Plank).
- **XML:** Used for GResource manifests (`gnome-shell-theme.gresource.xml`), Metacity themes, and AppStream metadata.

## Runtime

**Environment:**
- **Linux Shell:** The project is designed to run in a Linux terminal environment.
- **GNOME Shell:** Target environment for many features.

**Package Manager:**
- **System Package Managers:** Uses `apt`, `dnf`, `pacman`, `zypper`, `swupd`, `xbps`, and `eopkg` to manage build-time dependencies.

## Frameworks

**Core:**
- **GTK 4.0:** Primary target for modern GNOME applications and Libadwaita.
- **GTK 3.0:** Target for older GNOME applications and other desktop environments.
- **GTK 2.0:** Legacy support for older applications.

**Testing:**
- **Not detected:** No formal testing framework identified.

**Build/Dev:**
- **Sassc:** Used to compile SCSS to CSS.
- **Inkscape:** Used to render SVG assets into PNGs.
- **Optipng:** Used to optimize rendered PNG assets.
- **Glib-compile-resources:** Used to bundle theme files into GResource binary files.

## Key Dependencies

**Critical:**
- `sassc`: Essential for generating CSS from source styles.
- `libglib2.0-dev-bin` / `glib2-devel`: Provides `glib-compile-resources` for GDM and GTK resource bundling.
- `libxml2-utils`: Provides `xmllint` for XML validation.

**Infrastructure:**
- `imagemagick`: Used for background blurring and processing.
- `dialog`: Used for interactive installation menus.
- `ostree` & `flatpak`: Used for generating and installing Flatpak theme bundles.

## Configuration

**Environment:**
- Configured via shell script variables and command-line arguments.
- Requires root privileges (`sudo`) for system-wide installation.

**Build:**
- `parse-sass.sh`: Main script for CSS generation.
- `src/assets/render-all-assets.sh`: Main script for asset rendering.

## Platform Requirements

**Development:**
- Linux distribution with Bash, SASS compiler, and asset rendering tools (Inkscape, Optipng).

**Production:**
- Linux desktop environment supporting GTK or specific themes (GNOME, Cinnamon, XFCE, etc.).

---

*Stack analysis: 2025-02-12*
