---
title: True AMOLED black dark mode
area: themes
status: todo
created: 2026-05-04
tags: [feature, theme-variant, amoled, dark-mode]
---

# True AMOLED black dark mode

## Description
Implement a "True Black" variant of the theme optimized for AMOLED displays. This variant should use absolute black (`#000000`) for primary backgrounds instead of the standard dark gray, reducing power consumption on OLED/AMOLED screens and providing higher contrast.

## Success Criteria
- [ ] Define a new color palette or variable set for AMOLED black.
- [ ] Update `src/sass/_colors.scss` to support the new variant.
- [ ] Ensure all components (GTK, GNOME Shell, Cinnamon) respect the AMOLED black background when the variant is selected.
- [ ] Integrate with `install.sh` and `tweaks.sh` to allow users to install this specific variant.
- [ ] Verify readability and contrast with `#000000` backgrounds.

## Technical Notes
- Primary target: `src/sass/_colors.scss` and `src/sass/_colors-palette.scss`.
- Will likely require a new command-line flag in `install.sh` (e.g., `--amoled`).
- Consider how to handle "solid" vs "translucent" versions with true black.
