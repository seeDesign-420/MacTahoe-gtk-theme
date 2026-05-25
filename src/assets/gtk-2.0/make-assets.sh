#! /usr/bin/env bash

for color in '-Light' '-Dark'; do
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
      if [[ "$color" == '-Dark' ]]; then
        if [[ "$type" == '-nord' ]]; then
          bg_color='#2b303b'
          base_color='#1e222a'
        else
          bg_color='#181825'
          base_color='#1e1e2e'
        fi
      else
        bg_color='#f3f4f6'
        base_color='#fbfcfd'
      fi
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
      rm -rf "assets${color}${theme}${type}.svg"
      cp -rf "assets${color}.svg" "assets${color}${theme}${type}.svg"
      sed -i "s/#0860F2/${theme_color}/g" "assets${color}${theme}${type}.svg"
      if [[ "$color" == '-Dark' ]]; then
        sed -i "s/#333333/${bg_color}/g" "assets${color}${theme}${type}.svg"
        sed -i "s/#242424/${base_color}/g" "assets${color}${theme}${type}.svg"
      else
        sed -i "s/#f5f5f5/${bg_color}/g" "assets${color}${theme}${type}.svg"
        sed -i "s/#ffffff/${base_color}/g" "assets${color}${theme}${type}.svg"
      fi
    elif [[ "$theme" != '' ]]; then
      rm -rf "assets${color}${theme}.svg"
      cp -rf "assets${color}.svg" "assets${color}${theme}.svg"
      sed -i "s/#0860F2/${theme_color}/g" "assets${color}${theme}.svg"
    fi
  done
done
done

echo -e "DONE!"
