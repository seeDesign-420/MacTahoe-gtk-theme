#! /usr/bin/env bash

for color in 'Light' 'Dark'; do
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
      if [[ "$color" == 'Dark' ]]; then
         if [[ "$type" == '-nord' ]]; then
           base_color='#1e2229'
           text_color='#d9dce3'
           bg_color='#2b303b'
           tooltip_bg_color='#222730'
           insensitive_fg_color='#495265'
           dark_sidebar_bg='#323844'
         else
           base_color='#1e1e2e'
           text_color='#cdd6f4'
           bg_color='#181825'
           tooltip_bg_color='#11111b'
           insensitive_fg_color='#7f849c'
           dark_sidebar_bg='#313244'
         fi
      else
         base_color='#fbfcfd'
         text_color='#2d333e'
         bg_color='#f3f4f6'
         tooltip_bg_color='#f9fafb'
         insensitive_fg_color='#6a7792'
         dark_sidebar_bg='#f6f7f8'
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
      rm -rf "gtkrc-${color}${theme}${type}"
      cp -rf "gtkrc-${color}" "gtkrc-${color}${theme}${type}"
      sed -i "s/#0860f2/${theme_color}/g" "gtkrc-${color}${theme}${type}"
      if [[ "$color" == 'Dark' ]]; then
        sed -i "s/#242424/${base_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#dedede/${text_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#333333/${bg_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#2a2a2a/${tooltip_bg_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#565656/${insensitive_fg_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#3b3b3b/${dark_sidebar_bg}/g" "gtkrc-${color}${theme}${type}"
      else
        sed -i "s/#ffffff/${base_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#363636/${text_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#f5f5f5/${bg_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#fafafa/${tooltip_bg_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#7e7e7e/${insensitive_fg_color}/g" "gtkrc-${color}${theme}${type}"
        sed -i "s/#f7f7f7/${dark_sidebar_bg}/g" "gtkrc-${color}${theme}${type}"
      fi
    elif [[ "$theme" != '' ]]; then
      rm -rf "gtkrc-${color}${theme}"
      cp -rf "gtkrc-${color}" "gtkrc-${color}${theme}"
      sed -i "s/#0860f2/${theme_color}/g" "gtkrc-${color}${theme}"
    fi
  done
done
done

echo -e "DONE!"
