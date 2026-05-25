#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

INDEX="assets.txt"
ASSETS_DIR="assets"
SRC_FILE="assets.svg"

[[ -d $ASSETS_DIR ]] && rm -rf $ASSETS_DIR
mkdir -p $ASSETS_DIR

for i in `cat $INDEX`; do
  if [ -f $ASSETS_DIR/$i.png ]; then
    echo $ASSETS_DIR/$i.png exists.
  else
    echo
    echo Rendering $ASSETS_DIR/$i.png
    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-filename=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null
    $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png
  fi

  if [ -f $ASSETS_DIR/$i@2.png ]; then
    echo $ASSETS_DIR/$i@2.png exists.
  else
    echo
    echo Rendering $ASSETS_DIR/$i@2.png
    $INKSCAPE --export-id=$i \
              --export-dpi=192 \
              --export-id-only \
              --export-filename=$ASSETS_DIR/$i@2.png $SRC_FILE >/dev/null
    $OPTIPNG -o7 --quiet $ASSETS_DIR/$i@2.png
  fi
done

CATPPUCCIN_WORK_DIR="$(mktemp -d)"
CATPPUCCIN_INDEX="${CATPPUCCIN_WORK_DIR}/assets-catppuccin.txt"
CATPPUCCIN_SRC_FILE="${CATPPUCCIN_WORK_DIR}/assets-catppuccin.svg"

cleanup_catppuccin_tmp() {
  rm -rf "$CATPPUCCIN_WORK_DIR"
}

trap cleanup_catppuccin_tmp EXIT

cp "$INDEX" "$CATPPUCCIN_INDEX"
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
  "$CATPPUCCIN_INDEX"
cp "assets.svg" "$CATPPUCCIN_SRC_FILE"
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
  "$CATPPUCCIN_SRC_FILE"

mkdir -p "$ASSETS_DIR"

for i in `cat "$CATPPUCCIN_INDEX"`; do
  if [[ -f "$ASSETS_DIR/$i.png" ]]; then
    echo "'$ASSETS_DIR/$i.png' exists."
  else
    echo "Rendering '$ASSETS_DIR/$i.png'"
    if [[ -n "${RENDER_SVG}" ]]; then
      "$RENDER_SVG" --export-id "$i" \
                    "$CATPPUCCIN_SRC_FILE" "$ASSETS_DIR/$i.png"
    else
      "$INKSCAPE" --export-id="$i" \
                  --export-id-only \
                  --export-filename="$ASSETS_DIR/$i.png" "$CATPPUCCIN_SRC_FILE" >/dev/null
    fi
    if [[ -n "${OPTIPNG}" ]]; then
      "$OPTIPNG" -o7 --quiet "$ASSETS_DIR/$i.png"
    fi
  fi
done

exit 0
