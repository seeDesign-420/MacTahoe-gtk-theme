# Coding Conventions

**Analysis Date:** 2025-02-11

## Naming Patterns

**Files:**
- Shell scripts: `kebab-case.sh` (e.g., `install.sh`, `make-release.sh`).
- SASS partials: `_kebab-case.scss` (e.g., `_variables.scss`, `_colors.scss`).
- Library files: `lib-kebab-case.sh` in `libs/` (e.g., `libs/lib-core.sh`).

**Functions:**
- Shell functions: `snake_case` (e.g., `has_command`, `start_animation`).
- SASS functions: `snake_case` (e.g., `to_em`, `gtkalpha`).

**Variables:**
- Shell Globals/Constants: `SCREAMING_SNAKE_CASE` (e.g., `REPO_DIR`, `THEME_NAME`).
- Shell Locals: `snake_case` (e.g., `local color`, `local target_dir`).
- SASS Variables: `$kebab-case` (e.g., `$base-color`, `$selected-bg-color`).

**Types:**
- Not applicable (primarily Shell and SASS).

## Code Style

**Formatting:**
- Shell: `beautysh` is used with 2-space indentation (`beautysh -i 2 -s paronly`).
- SASS: 2-space indentation observed.

**Linting:**
- No formal linter configuration detected, but `beautysh` acts as a style enforcer for shell scripts.

## Import Organization

**Order:**
1. Core libraries (e.g., `source "${REPO_DIR}/libs/lib-core.sh"`).
2. Specialized libraries (e.g., `source "${REPO_DIR}/libs/lib-flatpak.sh"`).
3. Temporary configuration files in SASS (e.g., `@import 'theme-options-temp'`).

**Path Aliases:**
- Not used. Absolute paths are constructed using `REPO_DIR` or `THEME_SRC_DIR`.

## Error Handling

**Patterns:**
- Shell scripts use `set -Eeo pipefail` for strict error behavior.
- `trap` is used to handle signals (`EXIT`, `ERR`, `INT`, `TERM`, `TSTP`) in `libs/lib-core.sh`.
- Custom `signal_error` function provides detailed logs and system info upon failure.
- A lock directory `/tmp/MacTahoe.lock` is used to prevent concurrent execution and store error logs.

## Logging

**Framework:** Custom `prompt` function in `libs/lib-core.sh`.

**Patterns:**
- `-s`: Success (green).
- `-e`: Error (red).
- `-w`: Warning (yellow).
- `-i`: Info (cyan).
- `-t`: Title (magenta).

## Comments

**When to Comment:**
- Header blocks for section separators (e.g., `################ VARIABLES ################`).
- WARNING/SUGGESTION blocks at the start of scripts to guide contributors.
- TODO comments for planned improvements.

**JSDoc/TSDoc:**
- Not used.

## Function Design

**Size:** Functions are generally focused on a single task (e.g., `install_shelly`, `prepare_deps`).

**Parameters:** Use of `local` variables to capture positional parameters (e.g., `local color="${1}"`).

**Return Values:** Standard shell exit codes. Helper functions like `has_command` return 0/1 for boolean checks.

## Module Design

**Exports:** Environment variables are exported when needed by subshells (e.g., `export MACTAHOE_PID`).

**Barrel Files:** `libs/lib-install.sh` acts as a barrel for other libraries.

---

*Convention analysis: 2025-02-11*
