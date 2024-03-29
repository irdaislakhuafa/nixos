{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs;[
    hyprland
    waybar
  ];
  programs.hyprland.enable = false;
  programs.hyprland.xwayland.enable = true;
  programs.waybar.enable = true;
}
