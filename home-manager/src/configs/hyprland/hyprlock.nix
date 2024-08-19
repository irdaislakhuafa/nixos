{ pkgs, config, ... }:
let
  settings = import ./settings.nix { inherit config; };
in
{
  home.file.".config/${settings.dirName}/logo.png".source = settings.locker.image.path;
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = (
    let
      globalPosition = 50;
    in
    {
      general = {
        disable_loading_bar = false;
        grace = 0;
        no_fade_in = false;
        no_fade_out = false;
        hide_cursor = false;
        ignore_empty_input = true;
      };
      background = {
        path = "${settings.dir}/wallpaper.png";
        blur_size = 8;
        blur_passes = 3;
      };
      image = {
        path = "${settings.dir}/logo.png";
        size = 150; # lesser side if not 1:1 ratio
        rounding = -1; # negative values mean circle
        border_size = 1;
        border_color = "rgb(221, 221, 221)";
        rotate = 0; # degrees, counter-clockwise
        reload_time = -1; # seconds between reloading, 0 to reload with SIGUSR2

        position = "0, ${toString (0 + globalPosition)}";
        halign = "center";
        valign = "center";
      };
      label = {
        text = "Hi there, $DESC";
        text_align = "center"; # center/right or any value for default left. multi-line text alignment inside label container
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 20;
        font_family = "Noto Sans";
        rotate = 0; # degrees, counter-clockwise

        position = "0, ${toString (-130 + globalPosition)}";
        halign = "center";
        valign = "center";
      };
      input-field = [{
        size = "200, 40";
        position = "0, ${toString (-190 + globalPosition)}";
        dots_center = true;
        fade_on_empty = true;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 1;
        placeholder_text = ''Password...'';
        shadow_passes = 1;
      }];
    }
  );
}
