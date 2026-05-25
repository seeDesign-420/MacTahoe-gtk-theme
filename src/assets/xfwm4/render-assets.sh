#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

INDEX="assets.txt"
CATPPUCCIN_WORK_DIR="$(mktemp -d)"

cleanup_catppuccin_tmp() {
  rm -rf "$CATPPUCCIN_WORK_DIR"
}

trap cleanup_catppuccin_tmp EXIT

cp "assets-Dark-nord.svg" "${CATPPUCCIN_WORK_DIR}/assets-Dark-catppuccin.svg"
cp "assets-Light-nord.svg" "${CATPPUCCIN_WORK_DIR}/assets-Light-catppuccin.svg"
sed -i \
  -e 's/-nord/-catppuccin/g' \
  -e 's/#5271ad/#89b4fa/g' \
  -e 's/#4c7bd9/#74c7ec/g' \
  -e 's/#b57daa/#cba6f7/g' \
  -e 's/#cd7092/#f5c2e7/g' \
  -e 's/#c35b65/#f38ba8/g' \
  -e 's/#d0846c/#fab387/g' \
  -e 's/#e4b558/#f9e2af/g' \
  -e 's/#82ac5d/#a6e3a1/g' \
  -e 's/#8999a9/#7f849c/g' \
  -e 's/#1e2229/#1e1e2e/g' \
  -e 's/#2b303b/#181825/g' \
  -e 's/#fbfcfd/#cdd6f4/g' \
  -e 's/#d9dce3/#cdd6f4/g' \
  "${CATPPUCCIN_WORK_DIR}/assets-Dark-catppuccin.svg" \
  "${CATPPUCCIN_WORK_DIR}/assets-Light-catppuccin.svg"

for i in `cat $INDEX`; do
  for color in '-Dark' '-Light'; do
    for theme in '' '-nord' '-catppuccin'; do
      for screen in '' '-hdpi' '-xhdpi'; do
        ASSETS_DIR="assets${color}${theme}${screen}"
        if [[ "${theme}" == '-catppuccin' ]]; then
          SRC_FILE="${CATPPUCCIN_WORK_DIR}/assets${color}${theme}.svg"
        else
          SRC_FILE="assets${color}${theme}.svg"
        fi

        case "${screen}" in
            -hdpi)
              DPI='144'
              ;;
            -xhdpi)
              DPI='192'
               ;;
            *)
              DPI='96'
              ;;
        esac

        mkdir -p $ASSETS_DIR

        if [ -f $ASSETS_DIR/$i.png ]; then
          echo $ASSETS_DIR/$i.png exists.
        else
          echo
          echo Rendering $ASSETS_DIR/$i.png
          $INKSCAPE --export-id=$i \
                    --export-id-only \
                    --export-dpi=$DPI \
                    --export-filename=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
          if [[ -x "$OPTIPNG" ]]; then
            $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png
          fi
        fi
      done
    done
  done
done

exit 0
