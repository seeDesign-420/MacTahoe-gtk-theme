# Technology Stack

**Analysis Date:** 2026-05-24

## Languages

**Primary:**
- SCSS - Theme styling logic and variables, located in `src/sass/`
- Bash - Installation, build, and maintenance scripts (`install.sh`, `libs/*.sh`, `src/assets/*.sh`)

**Secondary:**
- CSS - Compiled style sheets for GTK and GNOME Shell
- Python 3 - Fildem Global Menu/HUD implementation in `Fildem-Gnome-45/fildem/`
- JavaScript - GNOME Shell extensions logic in `Fildem-Gnome-45/fildemGMenu@gonza.com/`
- XML - Configuration for GResources (`src/main/gnome-shell/gnome-shell-theme.gresource.xml`) and GNOME Shell metadata

## Runtime

**Environment:**
- Linux Desktop (GNOME, Cinnamon, XFCE, Budgie)
- GNOME Shell 3.28 to 48+
- Python 3.x for HUD/Global Menu

**Package Manager:**
- None (Shell-based installation)
- Python `setuptools` used for Fildem component

## Frameworks

**Core:**
- GTK 2.0 - Legacy support, assets in `src/assets/gtk-2.0/`
- GTK 3.0 - Primary styling, located in `src/main/gtk-3.0/`
- GTK 4.0 / Libadwaita - Modern GTK support, located in `src/main/gtk-4.0/`
- GNOME Shell - Desktop environment shell styling in `src/main/gnome-shell/`
- Cinnamon - Desktop environment styling in `src/main/cinnamon/`
- XFWM4 - XFCE Window Manager styling in `src/main/xfwm4/`

**Testing:**
- Not detected (Manual visual verification)

**Build/Dev:**
- `sassc` - Compiles SCSS to CSS
- `inkscape` - Renders SVG assets to PNG/SVG variants
- `optipng` - Optimizes rendered PNG assets
- `glib-compile-resources` - Compiles assets into GResource files for GDM and GNOME Shell

## Key Dependencies

**Critical:**
- `sassc` - Essential for generating theme CSS from source SCSS
- `libglib2.0-dev-bin` - Provides `glib-compile-resources`

**Infrastructure:**
- `inkscape` - Required for asset generation from templates
- `optipng` - Required for asset optimization
- `ostree` / `flatpak` - Required for generating and installing Flatpak theme bundles (`libs/lib-flatpak.sh`)
- `PyGObject` - Python bindings for GTK/GLib, required for Fildem component

## Configuration

**Environment:**
- `THEME_DIR` - Set via `-d` flag in `install.sh`, defaults to `~/.themes` or `/usr/share/themes`
- `REPO_DIR` - Inferred from the script location to locate source files

**Build:**
- `src/sass/_variables.scss` - Core theme configuration
- `src/sass/_theme-options.scss` - User-customizable options during installation

## Platform Requirements

**Development:**
- Linux with `bash`, `sassc`, `inkscape`, `optipng`, `glib-compile-resources`
- `tar`, `xz` for packaging

**Production:**
- GNOME-based or GTK-compatible Linux distribution

---

*Stack analysis: 2026-05-24*
