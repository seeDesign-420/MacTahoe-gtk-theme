# Codebase Structure

**Analysis Date:** 2025-02-12

## Directory Layout

```
[project-root]/
├── libs/           # Shell script libraries for installation logic
├── src/            # Core theme source files (SASS, assets, main templates)
│   ├── assets/     # Images and SVGs for various environments
│   ├── main/       # Component-specific SASS entry points and static files
│   └── sass/       # Shared SASS variables, colors, and base styles
├── other/          # Third-party app integrations (Firefox, GDM, Plank, etc.)
├── release/        # Pre-built theme archives
├── wallpaper/      # Source wallpapers and XML config
├── install.sh      # Main theme installation script
├── tweaks.sh       # Integration and customization script
└── parse-sass.sh   # SASS to CSS compilation helper
```

## Directory Purposes

**libs/:**
- Purpose: Contains modularized shell logic used by `install.sh` and `tweaks.sh`.
- Contains: Helper functions for system detection, file management, and dependency installation.
- Key files: `lib-core.sh`, `lib-install.sh`, `lib-flatpak.sh`.

**src/sass/:**
- Purpose: The core styling logic using SASS.
- Contains: Variables, color palettes, and base component styles shared across GTK versions and desktop environments.
- Key files: `_colors.scss`, `_variables.scss`, `_gtk-base.scss`.

**src/main/:**
- Purpose: Host-specific SASS entry points and legacy static configuration.
- Contains: SCSS files that @import from `src/sass/` for specific targets like `gtk-3.0`, `gtk-4.0`, or `gnome-shell`. Also contains GTK2 `.rc` files.
- Key files: `gtk-3.0/gtk-Dark.scss`, `gnome-shell/gnome-shell.scss`.

**src/assets/:**
- Purpose: Visual assets for all theme variants.
- Contains: Subdirectories for each supported environment (Cinnamon, GNOME Shell, GTK, XFWM4) with PNGs and SVGs.
- Key files: `gtk/scalable/`, `gnome-shell/common-assets/`.

**other/:**
- Purpose: Integration files for applications outside the standard GTK/Shell scope.
- Contains: Firefox `userChrome.css` templates, GDM resource XMLs, and Plank dock themes.
- Key files: `firefox/userChrome.css`, `gdm/gnome-shell-theme.gresource.xml`.

**release/:**
- Purpose: Distribution point for pre-compiled themes.
- Contains: `.tar.xz` archives of various theme combinations.

## Key File Locations

**Entry Points:**
- `install.sh`: The primary script for installing the GTK and GNOME Shell themes.
- `tweaks.sh`: Script for application-specific tweaks (Firefox, Flatpak, GDM).
- `parse-sass.sh`: Developer utility to compile all SASS sources.

**Configuration:**
- `libs/lib-core.sh`: Global configuration, variant definitions, and system paths.
- `src/sass/_variables.scss`: SASS-level configuration.

**Core Logic:**
- `libs/lib-install.sh`: Implementation of the installation algorithms.

**Testing:**
- Not detected: Project uses manual visual verification instead of automated tests.

## Naming Conventions

**Files:**
- SASS Partials: `_filename.scss` (e.g., `_colors.scss`).
- Entry SASS: `target-variant.scss` (e.g., `gtk-Dark.scss`).
- Scripts: `kebab-case.sh`.

**Directories:**
- Feature/Component: `kebab-case` or `component-version` (e.g., `dash-to-dock`, `gtk-3.0`).

## Where to Add New Code

**New Visual Style/Variable:**
- Add to `src/sass/_variables.scss` or `src/sass/_colors-palette.scss`.

**New GTK/Shell Component Style:**
- Add to the corresponding SASS partial in `src/sass/` (e.g., `_gtk-base.scss` for general GTK widgets).

**New External App Integration:**
- Create a new subdirectory in `other/`.
- Add installation logic to `tweaks.sh` and `libs/lib-install.sh`.

**New Asset:**
- Place in the appropriate subdirectory within `src/assets/`, ensuring it follows the variant naming pattern if applicable.

## Special Directories

**release/:**
- Purpose: Contains pre-built binaries/archives for end-users.
- Generated: Yes (via `make-release.sh`).
- Committed: Yes.

**.git/:**
- Purpose: Git version control metadata.
- Generated: Yes.
- Committed: No.

---

*Structure analysis: 2025-02-12*
