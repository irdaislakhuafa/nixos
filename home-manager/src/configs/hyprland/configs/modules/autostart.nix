{ config, pkgs, ... }: ''
  exec = ${pkgs.psmisc}/bin/killall ${pkgs.swaybg}/bin/hyprnotify
  exec = ${pkgs.hyprnotify}/bin/hyprnotify
  # exec = ${pkgs.psmisc}/bin/killall ${pkgs.swaybg}/bin/swaybg
  # exec = ${pkgs.swaybg}/bin/swaybg -i $HOME/.config/hypr/wallpaper.png 
''
