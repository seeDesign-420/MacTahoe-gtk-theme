# Architecture

**Analysis Date:** 2025-02-12

## Pattern Overview

**Overall:** Template-driven Theme Build and Installation System.

The codebase follows a "Source-to-Variant" architectural pattern. It uses SASS templates and shell scripts to dynamically generate hundreds of theme variations based on user-selected parameters (color, opacity, accent, etc.).

**Key Characteristics:**
- **Dynamic SASS Generation:** Uses temporary `-temp.scss` files and `sed` to inject user configurations into SASS variables before compilation.
- **Modularity:** Core logic is decoupled into library scripts (`libs/`) and component-specific source directories (`src/main/`).
- **Combinatorial Variant Management:** A nested loop structure in the installer generates all requested permutations of Light/Dark, Solid/Transparent, and Accent colors.

## Layers

**Configuration Layer:**
- Purpose: Defines the available variants and system paths.
- Location: `libs/lib-core.sh`
- Contains: Global variables, variant definitions (COLOR_VARIANTS, THEME_VARIANTS), and path constants.
- Depends on: System environment (GNOME version, user home).
- Used by: All installation and build scripts.

**Build Layer:**
- Purpose: Compiles SASS templates into CSS and manages assets.
- Location: `src/sass/`, `src/main/`, `parse-sass.sh`
- Contains: SASS partials, component entry points, and the compilation script.
- Depends on: `sassc`, `src/assets/`
- Used by: `libs/lib-install.sh`

**Installation Layer:**
- Purpose: Handles dependency checks, file placement, and environment tweaks.
- Location: `install.sh`, `tweaks.sh`, `libs/lib-install.sh`
- Contains: Logic for theme distribution to standard Linux directories and application-specific paths (Firefox, GDM, Flatpak).
- Depends on: Build Layer, Configuration Layer.
- Used by: End-user.

## Data Flow

**Theme Installation Flow:**

1. **Parameter Parsing:** `install.sh` parses CLI arguments using `check_param` from `libs/lib-core.sh`.
2. **Environment Preparation:** `libs/lib-install.sh` checks for dependencies (`sassc`, `glib2`, etc.) and detects the host environment (Distro, GNOME version).
3. **Template Configuration:** `gtk_base` and `customize_theme` in `libs/lib-install.sh` create temporary `.scss` files by applying `sed` replacements to the source templates in `src/sass/`.
4. **Compilation:** `sassc` compiles the configured SASS templates from `src/main/` into CSS.
5. **Asset Assembly:** `install_theemy` and `install_shelly` copy the compiled CSS and matching assets from `src/assets/` to the destination directory.
6. **Integration:** Tweaks are applied for specific applications (Firefox, Dash-to-Dock) or system components (GDM).

**State Management:**
- **Transient State:** Handled via environment variables and temporary files in `/tmp/MacTahoe.lock`.
- **Persistent State:** Handled by the target filesystem (standard theme directories like `~/.themes` or `/usr/share/themes`).

## Key Abstractions

**Library Modules:**
- Purpose: Encapsulate shared logic for installation and external integrations.
- Examples: `libs/lib-install.sh`, `libs/lib-flatpak.sh`
- Pattern: Shell Script Library (Sourced functions).

**Theme Variants:**
- Purpose: Represents a specific combination of visual attributes.
- Examples: `src/main/gtk-3.0/gtk-Dark.scss`, `src/assets/gtk/thumbnails/`
- Pattern: SASS Mixins and Variable Overrides.

## Entry Points

**Primary Installer:**
- Location: `install.sh`
- Triggers: User CLI execution.
- Responsibilities: Main entry for full theme installation and uninstallation.

**Tweaks Manager:**
- Location: `tweaks.sh`
- Triggers: User CLI execution.
- Responsibilities: Handles GDM, Firefox, Flatpak, and Dash-to-Dock specific integrations.

**Build Helper:**
- Location: `parse-sass.sh`
- Triggers: Developer execution.
- Responsibilities: Simplifies SASS to CSS compilation for development.

## Error Handling

**Strategy:** Trap-based signal handling and defensive programming in shell scripts.

**Patterns:**
- **Error Traps:** `trap 'signal_error' ERR` in `libs/lib-core.sh` captures command failures and prints detailed system/environment logs.
- **Safety Locks:** Uses `/tmp/MacTahoe.lock` to prevent concurrent installer runs.
- **Backup/Restore:** Utility functions `backup_file` and `restore_file` manage safe modification of system config files.

## Cross-Cutting Concerns

**Logging:** Standard output with color-coded prompts (`prompt -i`, `-e`, etc.) and an error log file in `/tmp/`.
**Validation:** `check_param` validates all CLI inputs against allowed variants.
**Authentication:** `sudo` and `udo` wrappers in `libs/lib-core.sh` manage privilege escalation when writing to system directories.

---

*Architecture analysis: 2025-02-12*
