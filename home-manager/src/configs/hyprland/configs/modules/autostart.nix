{ config, pkgs, ... }: ''
  exec = ${pkgs.procps}/bin/pidof hyprnotify || ${pkgs.hyprnotify}/bin/hyprnotify
''
