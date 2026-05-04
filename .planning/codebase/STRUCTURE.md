# Codebase Structure

**Analysis Date:** 2026-05-24

## Directory Layout

```
MacTahoe-gtk-theme/
├── src/                # Theme source code and assets
│   ├── sass/           # Modular SCSS files and variables
│   ├── main/           # Platform-specific SCSS entry points
│   └── assets/         # Icons, thumbnails, and graphical assets
├── libs/               # Shared bash library scripts
├── other/              # Extra themes and integrations
│   ├── firefox/        # Firefox browser theme
│   ├── gdm/            # GNOME Display Manager theme source
│   ├── plank/          # Plank dock themes
│   └── dash-to-dock/   # Dash-to-dock extension styles
├── wallpaper/          # Source wallpapers and installer
├── release/            # Pre-packaged theme archives (generated)
├── install.sh          # Main installation script
└── tweaks.sh           # Post-installation customization script
```

## Directory Purposes

**src/sass/:**
- Purpose: Contains the core styling logic shared across different platforms.
- Contains: SCSS variables (`_variables.scss`), color palettes (`_colors.scss`), and platform-specific modules (GTK, GNOME Shell, Cinnamon).

**src/main/:**
- Purpose: Entry points for SCSS compilation.
- Contains: Files like `gtk-Dark.scss` or `gnome-shell-Light.scss` which import modular files from `src/sass/`.

**libs/:**
- Purpose: Reusable bash logic to keep `install.sh` clean.
- Contains: `lib-core.sh` (utilites), `lib-install.sh` (theme installation logic), `lib-flatpak.sh` (Flatpak integration).

**other/:**
- Purpose: Hosts non-standard theme components and third-party app integrations.
- Key files: `other/gdm/make_gresource.sh` for bundling GDM themes.

**wallpaper/:**
- Purpose: Provides the MacTahoe branded backgrounds used by GDM and GNOME.
- Key files: `install-gnome-backgrounds.sh`

## Key File Locations

**Entry Points:**
- `install.sh`: The primary installer for all theme variants.
- `tweaks.sh`: Utility for applying specific patches or changing options after install.
- `parse-sass.sh`: Developer utility to manually recompile all SCSS.

**Configuration:**
- `src/sass/_variables.scss`: Core theme measurements and constants.
- `src/sass/_colors-palette.scss`: Primary color definitions.

**Core Logic:**
- `libs/lib-install.sh`: Contains the heavy lifting for file movement and SASS compilation.

**Testing:**
- `test-pathbar.css`: CSS file likely used for visual debugging of the pathbar component.

## Naming Conventions

**Files:**
- SCSS Partials: `_*.scss` (e.g., `_common.scss`)
- Scripts: `*.sh` (e.g., `clean-git.sh`)

**Directories:**
- Plural nouns for collections: `assets`, `libs`, `other`.

## Where to Add New Code

**New Feature (e.g., support for a new desktop environment):**
- Primary code: Create a new directory in `src/sass/[env]` and `src/main/[env]`.
- Logic: Add an `install_[env]` function in `libs/lib-install.sh`.
- Entry: Update `install.sh` to include the new option.

**New Component/Module:**
- Implementation: Add a new partial in `src/sass/gtk/` or `src/sass/gnome-shell/common/`.

**Utilities:**
- Shared helpers: `libs/lib-core.sh`.

## Special Directories

**.planning/:**
- Purpose: GSD-specific project documentation and codebase mapping.
- Committed: Yes.

**release/:**
- Purpose: Contains compressed archives for distribution.
- Generated: Yes.
- Committed: Yes (in this repo).

---

*Structure analysis: 2026-05-24*
