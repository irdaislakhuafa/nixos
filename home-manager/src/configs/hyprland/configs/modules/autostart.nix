{ config, pkgs, ... }: ''
  exec-once = ${pkgs.psmisc}/bin/killall ${pkgs.swaybg}/bin/swaybg 
  exec-once = ${pkgs.swaybg}/bin/swaybg -i $HOME/.config/hypr/wallpaper.png &
''
