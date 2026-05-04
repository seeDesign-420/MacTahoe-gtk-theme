---
phase: 1
plan: 1
type: execute
wave: 1
depends_on: []
files_modified:
  - install.sh
  - libs/lib-install.sh
  - src/sass/_colors.scss
  - src/sass/_theme-options.scss
  - src/sass/_variables.scss
autonomous: true
requirements: ["GS-TRANSPARENT"]
must_haves:
  truths:
    - "Installer accepts --transparent / -tr flag"
    - "Generated CSS has 0 opacity for panel, popups, and dialogs"
    - "Light variant is also fully transparent"
  artifacts:
    - path: "install.sh"
      provides: "New CLI flag"
    - path: "libs/lib-install.sh"
      provides: "SASS variable injection"
    - path: "src/sass/_colors.scss"
      provides: "Corrected light variant logic"
---

# Phase 1: GNOME Shell Transparency Variant

## Objective
Implement a 100% transparent GNOME Shell variant by adding a new installation option and updating the SASS logic.

## Context
- `install.sh`
- `libs/lib-install.sh`
- `src/sass/_colors.scss`
- `src/sass/_theme-options.scss`
- `src/sass/_variables.scss`
- `.planning/todos/gnome-shell/transparent-variant.md`

## Tasks

<task type="auto">
  <name>Task 1: Add --transparent flag to installer</name>
  <files>install.sh</files>
  <action>
    - Add `-tr | --transparent` to the `usage()` function.
    - Add a case for `-tr | --transparent` in the argument parsing loop that sets `transparent="true"`.
  </action>
  <verify>
    <automated>./install.sh --help | grep -E "transparent|-tr"</automated>
  </verify>
</task>

<task type="auto">
  <name>Task 2: Prepare SASS variables for override</name>
  <files>src/sass/_theme-options.scss, src/sass/_variables.scss</files>
  <action>
    - Add `$trans_opacity` and `$popover_opacity` to `src/sass/_theme-options.scss` with their default values.
    - Update `src/sass/_variables.scss` to remove the hardcoded definitions of these variables, allowing them to be inherited from `_theme-options-temp.scss`.
  </action>
  <verify>
    <automated>grep "\$trans_opacity" src/sass/_theme-options.scss</automated>
  </verify>
</task>

<task type="auto">
  <name>Task 3: Inject transparency variables in customize_theme</name>
  <files>libs/lib-install.sh</files>
  <action>
    - In `customize_theme()`, check if `transparent` is "true".
    - If true, use `sed` to set the following in `src/sass/_theme-options-temp.scss`:
      - `$trans: 'true';`
      - `$trans_opacity: 0;`
      - `$panel_opacity: 0;`
      - `$popover_opacity: 0;`
  </action>
  <verify>
    <automated># Manual verification by checking the generated CSS after a trial installation</automated>
  </verify>
</task>

<task type="auto">
  <name>Task 4: Fix light variant transparency in _colors.scss</name>
  <files>src/sass/_colors.scss</files>
  <action>
    - Review `$panel_bg`, `$dialog_bg_color`, and `$menu_bg` in `src/sass/_colors.scss`.
    - Ensure that when `$trans` is 'true' and `$trans_opacity` is 0, the light variant background does not fall back to an opaque color.
    - Verify that text colors (e.g., `$panel_fg`, `$fg_color`) remain opaque and readable against a transparent background.
  </action>
  <verify>
    <automated>grep -A 5 "if(\$trans == 'true'" src/sass/_colors.scss</automated>
  </verify>
</task>

## Success Criteria
- Running `./install.sh --transparent` generates a theme where `gnome-shell.css` contains `rgba(..., 0)` for panel and popovers.
