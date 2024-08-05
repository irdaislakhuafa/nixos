{ config, pkgs, ... }: ''
  exec = ${pkgs.psmisc}/bin/killall ${pkgs.swaybg}/bin/hyprnotify
  exec = ${pkgs.hyprnotify}/bin/hyprnotify
''
