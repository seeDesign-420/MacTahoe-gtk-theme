# Coding Conventions

**Analysis Date:** 2026-05-22

## Naming Patterns

**Files:**
- Shell scripts: `kebab-case.sh` (e.g., `install.sh`, `parse-sass.sh`).
- SASS source files: `_kebab-case.scss` for partials (e.g., `_variables.scss`, `_drawing-3.0.scss`).
- Entry point SASS: `gtk-Color.scss` (e.g., `gtk-Light.scss`).
- Assets: `snake_case` or `kebab-case` (e.g., `src/assets/gtk/assets.svg`).

**Functions:**
- Bash: `snake_case` (e.g., `has_command`, `check_param`).
- SASS: `snake_case` (e.g., `to_em`).

**Variables:**
- Bash Constants: `SCREAMING_SNAKE_CASE` (e.g., `REPO_DIR`, `THEME_NAME`).
- Bash Local/Global state: `snake_case` or `lowercase` (e.g., `colors`, `activities_icon`).
- SASS: `snake_case` or `kebab-case` (e.g., `$base_padding`, `$panel-corner-radius`).

**Types:**
- Not applicable (primarily Bash and SASS).

## Code Style

**Formatting:**
- Bash: `beautysh` is used for formatting.
- Command: `beautysh -i 2 -s paronly *.sh`.
- Indentation: 2 spaces.

**Linting:**
- No automated linting detected, but `beautysh` is used for consistency.

## Import Organization

**Order:**
1. Variables: `@import '../../sass/variables';`
2. Colors: `@import '../../sass/colors';`
3. Drawing: `@import '../../sass/gtk/drawing-3.0';`
4. Common: `@import '../../sass/gtk/common-3.0';`
5. Apps/Specifics: `@import '../../sass/gtk/apps-3.0';`

**Path Aliases:**
- Relative paths are used throughout: `../../sass/...`.

## Error Handling

**Patterns:**
- Bash scripts use `set -Eeo pipefail` to ensure scripts stop on errors.
- Dependency checks: Scripts verify existence of `sassc`, `sudo`, etc., before proceeding.
- Import guarding: Shared libraries use a guard pattern:
  ```bash
  if [[ "${MACTAHOE_SOURCE[@]}" =~ "lib-core.sh" ]]; then
    echo "'lib-core.sh' is already imported"; exit 1
  fi
  MACTAHOE_SOURCE=("lib-core.sh")
  ```

## Logging

**Framework:** `echo` and custom helpify functions.

**Patterns:**
- Status messages: `echo "==> Generating the 3.0 gtk${color}.css..."`.
- Error messages: `echo "Please define 'REPODIR' variable"; exit 1`.

## Comments

**When to Comment:**
- Section headers in large scripts.
- TODOs for future integrations.
- Warnings about directory dependency or usage of `cd`.

**JSDoc/TSDoc:**
- Not applicable. Bash scripts use simple block comments for function descriptions.

## Function Design

**Size:** Functions are generally small and focused (e.g., `has_command`, `usage`).

**Parameters:**
- Bash: Standard positional parameters. Some use `check_param` helper for validation.

**Return Values:**
- Bash: Return codes for success/failure.

## Module Design

**Exports:**
- Bash: `source` and `export` are used to share variables and functions across scripts.

**Barrel Files:**
- `libs/lib-core.sh` acts as a central library for other scripts.

---

*Convention analysis: 2026-05-22*
