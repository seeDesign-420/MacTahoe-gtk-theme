#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

./make-thumbnails.sh

for theme in '' '-blue' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey'; do
  for type in '' '-nord' '-catppuccin'; do
    SRC_FILE="thumbnail${theme}${type}.svg"
    for color in '-light' '-dark'; do
            local_color="${color/-/}"
            output_color="${local_color^}"
            echo
            echo Rendering thumbnail-${output_color}${theme}${type}.png
            $INKSCAPE --export-id=thumbnail${color}${theme}${type} \
                      --export-id-only \
                      --export-dpi=192 \
                      --export-filename=thumbnail-${output_color}${theme}${type}.png $SRC_FILE >/dev/null \
            && $OPTIPNG -o7 --quiet thumbnail-${output_color}${theme}${type}.png
      done
    done
  done

for theme in '' '-blue' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey'; do
  for type in '' '-nord' '-catppuccin'; do
    if [[ ${theme} == '' && ${type} == '' ]]; then
      echo "keep thumbnail.svg"
    else
      rm -rf "thumbnail${theme}${type}.svg"
    fi
  done
done

exit 0
