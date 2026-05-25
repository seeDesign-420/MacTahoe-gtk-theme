#! /usr/bin/env bash

for theme in '' '-blue' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey'; do
  for type in '' '-nord' '-catppuccin'; do
    case "$theme" in
      '')
        theme_color='#0860F2'
        ;;
      -blue)
        theme_color='#2E7CF7'
        ;;
      -purple)
        theme_color='#9A57A3'
        ;;
      -pink)
        theme_color='#E55E9C'
        ;;
      -red)
        theme_color='#ED5F5D'
        ;;
      -orange)
        theme_color='#E9873A'
        ;;
      -yellow)
        theme_color='#F3BA4B'
        ;;
      -green)
        theme_color='#79B757'
        ;;
      -grey)
        theme_color='#8C8C8C'
        ;;
    esac

    if [[ "$type" == '-nord' || "$type" == '-catppuccin' ]]; then
      case "$theme" in
        '')
          theme_color='#5271ad'
          [[ "$type" == '-catppuccin' ]] && theme_color='#89b4fa'
          ;;
        -blue)
          theme_color='#4c7bd9'
          [[ "$type" == '-catppuccin' ]] && theme_color='#74c7ec'
          ;;
        -purple)
          theme_color='#b57daa'
          [[ "$type" == '-catppuccin' ]] && theme_color='#cba6f7'
          ;;
        -pink)
          theme_color='#cd7092'
          [[ "$type" == '-catppuccin' ]] && theme_color='#f5c2e7'
          ;;
        -red)
          theme_color='#c35b65'
          [[ "$type" == '-catppuccin' ]] && theme_color='#f38ba8'
          ;;
        -orange)
          theme_color='#d0846c'
          [[ "$type" == '-catppuccin' ]] && theme_color='#fab387'
          ;;
        -yellow)
          theme_color='#e4b558'
          [[ "$type" == '-catppuccin' ]] && theme_color='#f9e2af'
          ;;
        -green)
          theme_color='#82ac5d'
          [[ "$type" == '-catppuccin' ]] && theme_color='#a6e3a1'
          ;;
        -grey)
          theme_color='#8999a9'
          [[ "$type" == '-catppuccin' ]] && theme_color='#7f849c'
          ;;
      esac
    fi

    if [[ "$type" != '' ]]; then
      rm -rf "theme${theme}${type}"
      cp -rf "theme" "theme${theme}${type}"
      sed -i "s/#0860f2/${theme_color}/g" "theme${theme}${type}"/*.svg
    elif [[ "$theme" != '' ]]; then
      rm -rf "theme${theme}"
      cp -rf "theme" "theme${theme}"
      sed -i "s/#0860f2/${theme_color}/g" "theme${theme}"/*.svg
    fi
  done
done

for color in 'Dark' 'Light'; do
  for type in '-nord' '-catppuccin'; do
    rm -rf "assets-${color}${type}"
    cp -rf "assets-${color}" "assets-${color}${type}"
  done
done

echo -e "DONE!"
