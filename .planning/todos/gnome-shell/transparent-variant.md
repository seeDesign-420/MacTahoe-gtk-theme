---
title: Implement 100% transparent GNOME Shell variant
area: gnome-shell
status: todo
created: 2026-05-04
tags: [feature, gnome-shell, transparency]
---

# Implement 100% transparent GNOME Shell variant

## Description
Create a new variant of the theme where GNOME Shell elements like popups, dialogs, and the panel have 0% background opacity. The user intends for the background blur/visuals to be provided via another method (e.g., Blur My Shell extension or custom shaders).

## Success Criteria
- [ ] New SASS/CSS variant generated for transparent GNOME Shell.
- [ ] Popups and dialogs have `background-color: transparent` or `rgba(..., 0)`.
- [ ] Panel background is fully transparent.
- [ ] Text and icons remain readable (ensure contrast).
- [ ] Integration with `parse-sass.sh` to build this variant.

## Technical Notes
- Target files: `src/sass/gnome-shell/_common.scss` or new `_transparent.scss`.
- Check `other/gdm/` for consistency if GDM also needs transparency.
- Needs to be an optional build flag or a distinct theme name (e.g., `MacTahoe-Transparent`).
