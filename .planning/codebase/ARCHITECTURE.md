# Architecture

**Analysis Date:** 2026-05-24

## Pattern Overview

**Overall:** Modular Theme Compilation and Distribution

**Key Characteristics:**
- **Dynamic SCSS Compilation:** Themes are not pre-compiled; they are generated at install-time based on user preferences.
- **Variant-Based Iteration:** The system uses nested loops to generate dozens of theme combinations (Color x Opacity x Accent x Scheme).
- **Template-Driven Configuration:** Uses "temp" SCSS files (e.g., `_gtk-base-temp.scss`) that are modified via `sed` before compilation.

## Layers

**Configuration Layer:**
- Purpose: Defines the available variants, paths, and user options.
- Location: `libs/lib-core.sh` and `install.sh`
- Contains: Environment variables, variant definitions, and argument parsing logic.

**Logic Layer:**
- Purpose: Orchestrates the installation, compilation, and customization of themes.
- Location: `libs/lib-install.sh`
- Contains: Bash functions for installing dependencies, compiling SASS, and moving assets.

**Style Layer (SCSS):**
- Purpose: Source styles for all supported platforms.
- Location: `src/sass/`
- Contains: Modular SCSS components, mixins, and variables.
- Depends on: `src/sass/_variables.scss`, `src/sass/_colors.scss`

**Asset Layer:**
- Purpose: Static assets (icons, images, thumbnails) required by the themes.
- Location: `src/assets/`
- Contains: SVG icons, PNG thumbnails, and shell assets.

## Data Flow

**Theme Generation Flow:**

1. **User Input:** User runs `install.sh` with specific flags (e.g., `--blur --darker`).
2. **Template Preparation:** `customize_theme` and `gtk_base` copy source `.scss` files to `-temp.scss` versions.
3. **Property Injection:** `sed` commands in `libs/lib-install.sh` modify variables inside the `-temp.scss` files.
4. **Compilation:** `sassc` compiles the entry points in `src/main/` (which import the temp files) into CSS.
5. **Asset Assembly:** Static assets from `src/assets/` are copied to the destination alongside the compiled CSS.
6. **Resource Bundling (Optional):** For GDM or specific GTK versions, `glib-compile-resources` packages CSS and assets into a `.gresource` file.

**State Management:**
- Handled via shell variables and temporary files during the installation process.

## Key Abstractions

**Theme Module:**
- Purpose: A specific platform implementation (Shell, GTK, Cinnamon).
- Examples: `install_shelly`, `install_theemy` in `libs/lib-install.sh`.

**Variant Generator:**
- Purpose: Iterates through all selected permutations to create multiple theme directories.
- Pattern: Nested for-loops in `install_themes` function.

## Entry Points

**install.sh:**
- Location: `install.sh`
- Triggers: User execution from terminal.
- Responsibilities: CLI interface, argument validation, and calling the main installation loop.

**tweaks.sh:**
- Location: `tweaks.sh`
- Triggers: User execution.
- Responsibilities: Post-installation modifications and specific desktop environment tweaks.

## Error Handling

**Strategy:** Fail-soft with user notification.

**Patterns:**
- **Dependency Checks:** `has_command` checks for required tools (`sassc`, `glib-compile-resources`) before proceeding.
- **Cleanup:** `clean_themes` removes existing versions before re-installing to prevent state corruption.

## Cross-Cutting Concerns

**Logging:** Uses a custom `prompt` function in `libs/lib-core.sh` for formatted console output.
**Validation:** `check_param` ensures CLI arguments match supported variants.
**Authentication:** Elevation via `sudo` or `udo` (custom wrapper) is handled for system-wide installations.

---

*Architecture analysis: 2026-05-24*
