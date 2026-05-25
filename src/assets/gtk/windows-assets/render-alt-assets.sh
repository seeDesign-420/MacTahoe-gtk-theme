#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="windows-assets.svg"
ASSETS_DIR="titlebutton-alt"
NORD_SRC_FILE="windows-nord-assets.svg"
NORD_ASSETS_DIR="titlebutton-alt-nord"
INDEX="assets.txt"

## alt titlebutton

mkdir -p $ASSETS_DIR

for i in `cat $INDEX` ; do
for d in '' '-dark' ; do

if [ -f $ASSETS_DIR/$i$d.png ]; then
    echo $ASSETS_DIR/$i$d.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i$d.png
    $INKSCAPE --export-id=$i-alt$d \
              --export-id-only \
              --export-png=$ASSETS_DIR/$i$d.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i$d.png 
fi

if [ -f $ASSETS_DIR/$i$d@2.png ]; then
    echo $ASSETS_DIR/$i$d@2.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i$d@2.png
    $INKSCAPE --export-id=$i-alt$d \
              --export-dpi=192 \
              --export-id-only \
              --export-png=$ASSETS_DIR/$i$d@2.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i$d@2.png 
fi

done
done

## alt nord titlebutton

mkdir -p $NORD_ASSETS_DIR

for i in `cat $INDEX` ; do
for d in '' '-dark' ; do

if [ -f $NORD_ASSETS_DIR/$i$d.png ]; then
    echo $NORD_ASSETS_DIR/$i$d.png exists.
else
    echo
    echo Rendering $NORD_ASSETS_DIR/$i$d.png
    $INKSCAPE --export-id=$i$d \
              --export-id-only \
              --export-png=$NORD_ASSETS_DIR/$i$d.png $NORD_SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $NORD_ASSETS_DIR/$i$d.png 
fi

if [ -f $NORD_ASSETS_DIR/$i$d@2.png ]; then
    echo $NORD_ASSETS_DIR/$i$d@2.png exists.
else
    echo
    echo Rendering $NORD_ASSETS_DIR/$i$d@2.png
    $INKSCAPE --export-id=$i$d \
              --export-dpi=192 \
              --export-id-only \
              --export-png=$NORD_ASSETS_DIR/$i$d@2.png $NORD_SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $NORD_ASSETS_DIR/$i$d@2.png 
fi

done
done

## alt catppuccin titlebutton

CATPPUCCIN_SRC_FILE="windows-catppuccin-assets.svg"
CATPPUCCIN_ASSETS_DIR="titlebutton-alt-catppuccin"

if [ -f $CATPPUCCIN_SRC_FILE ]; then
mkdir -p $CATPPUCCIN_ASSETS_DIR

for i in `cat $INDEX` ; do
for d in '' '-dark' ; do

if [ -f $CATPPUCCIN_ASSETS_DIR/$i$d.png ]; then
    echo $CATPPUCCIN_ASSETS_DIR/$i$d.png exists.
else
    echo
    echo Rendering $CATPPUCCIN_ASSETS_DIR/$i$d.png
    $INKSCAPE --export-id=$i$d \
              --export-id-only \
              --export-png=$CATPPUCCIN_ASSETS_DIR/$i$d.png $CATPPUCCIN_SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $CATPPUCCIN_ASSETS_DIR/$i$d.png 
fi

if [ -f $CATPPUCCIN_ASSETS_DIR/$i$d@2.png ]; then
    echo $CATPPUCCIN_ASSETS_DIR/$i$d@2.png exists.
else
    echo
    echo Rendering $CATPPUCCIN_ASSETS_DIR/$i$d@2.png
    $INKSCAPE --export-id=$i$d \
              --export-dpi=192 \
              --export-id-only \
              --export-png=$CATPPUCCIN_ASSETS_DIR/$i$d@2.png $CATPPUCCIN_SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $CATPPUCCIN_ASSETS_DIR/$i$d@2.png 
fi

done
done
fi
exit 0
