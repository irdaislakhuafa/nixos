{ pkgs, config, ... }:
let
  settings = import ./settings.nix { inherit config; };
in
{
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      lock_cmd = ''pidof hyprlock || hyprlock'';
    };
    listener = [
      {
        timeout = (60 * 5);
        on-timeout = ''hyprlock'';
      }
      {
        timeout = (60 * 15); # in seconds
        on-timeout = ''notify-send "You are idle!" && hyprctl dispatch dpms off && systemctl suspend'';
        on-resume = ''notify-send "Welcome back!" && hyprctl dispatch dpms on'';
      }
    ];
  };
}