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
        timeout = (60 * 15);
        on-timeout = ''hyprlock'';
      }
      {
        timeout = (60 * 60); # in seconds
        on-timeout = ''notify-send -w "You are idle!" && systemctl suspend'';
        on-resume = ''notify-send -w "Welcome back!"'';
      }
    ];
  };
}
