---
title: Fix font icon anti-aliasing
area: gtk
status: todo
created: 2026-05-04
tags: [bug, icons, gtk, typography]
---

# Fix font icon anti-aliasing

## Description
The font icons used in the theme (e.g., in GTK apps) currently lack proper anti-aliasing, leading to "jagged" or pixelated edges on certain displays. This is likely due to missing CSS properties that control font smoothing or icon rendering.

## Success Criteria
- [ ] Identify where font icons are defined in the SCSS.
- [ ] Apply `-webkit-font-smoothing: antialiased` and `-moz-osx-font-smoothing: grayscale` where applicable.
- [ ] Ensure `-gtk-icon-shadow: none` is set if it's causing rendering artifacts, or use a subtle shadow to force subpixel rendering if needed.
- [ ] Verify icons look smooth across different GTK versions (GTK3/GTK4).

## Technical Notes
- Check `src/sass/gtk/_common.scss` or `src/sass/gtk/apps/_gnome-40.0.scss`.
- Some font-based icons might need `font-weight` adjustments to appear clearer.
