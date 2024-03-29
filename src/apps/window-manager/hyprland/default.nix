{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    hyprland
  ];
  programs.hyprland.enable = false;
  programs.hyprland.xwayland.enable = true;
}
