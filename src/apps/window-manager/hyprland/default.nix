{ pkgs, config, ... }: rec {
  environment.systemPackages = with pkgs;[
    hyprland
    waybar
    xdg-desktop-portal-hyprland
    polkit
    rofi-wayland
    hyprpaper
  ];
  programs.hyprland.enable = false;
  programs.hyprland.xwayland.enable = true;
  programs.waybar.enable = true;

  services.xserver.displayManager.session = [
    {
      manage = "window";
      name = "hyprland";
      start = ''
        ${pkgs.hyprland}/bin/Hyprland
      '';
    }
  ];
}
