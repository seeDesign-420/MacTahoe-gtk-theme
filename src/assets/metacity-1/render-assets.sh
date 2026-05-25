#! /usr/bin/env bash

set -euo pipefail

for color in Dark Light; do
  src_dir="titlebuttons-${color}"
  catppuccin_dir="titlebuttons-${color}-catppuccin"
  thumbnail_src="thumbnail-${color}.png"
  thumbnail_dst="thumbnail-${color}-catppuccin.png"

  if [[ ! -d "${catppuccin_dir}" ]]; then
    cp -r "${src_dir}" "${catppuccin_dir}"
  fi

  if [[ ! -f "${thumbnail_dst}" ]]; then
    cp "${thumbnail_src}" "${thumbnail_dst}"
  fi
done
