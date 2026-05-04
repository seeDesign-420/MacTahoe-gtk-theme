# Testing Patterns

**Analysis Date:** 2026-05-22

## Test Framework

**Runner:**
- None. Testing is primarily manual and visual.

**Assertion Library:**
- None.

**Run Commands:**
```bash
./parse-sass.sh        # Compiles SASS and verifies no syntax errors
./install.sh           # Tests installation process
./clean-git.sh         # Formats scripts and cleans the repo
```

## Test File Organization

**Location:**
- No dedicated test directory.
- `test-pathbar.css` in the root is used for manual CSS testing of Nautilus.

**Naming:**
- Manual test snippets: `test-*.css`.

**Structure:**
```
[project-root]/
├── test-pathbar.css
└── src/assets/render-all-assets.sh
```

## Test Structure

**Suite Organization:**
Not applicable. No automated test suites.

**Patterns:**
- Visual Verification: Developers install the theme and inspect UI elements (buttons, headerbars, menus) across different GNOME versions and applications.

## Mocking

**Framework:** None.

**Patterns:**
Not applicable.

## Fixtures and Factories

**Test Data:**
Not applicable.

**Location:**
Not applicable.

## Coverage

**Requirements:** No coverage metrics enforced.

**View Coverage:**
Not applicable.

## Test Types

**Unit Tests:**
- None.

**Integration Tests:**
- `parse-sass.sh`: Indirectly tests the integration of various SASS partials by attempting to compile them into valid CSS.

**E2E Tests:**
- `install.sh`: Tests the end-to-end installation flow, including environment detection, path creation, and file copying.

## Common Patterns

**Async Testing:**
Not applicable.

**Error Testing:**
- Dependency checks in scripts (e.g., checking for `sassc` or `gnome-shell`) serve as primitive error-path tests.

---

*Testing analysis: 2026-05-22*
