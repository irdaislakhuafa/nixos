{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    hyprland
    hyprkeys
    rofi-wayland
    wl-screenrec
    wl-clipboard
    wl-gammactl
    swaybg
    slurp
    grim
    waybar
    wlr-randr
    hyprpicker
    xdg-desktop-portal-hyprland
  ];
  
  programs.hyprland.enable = false;
  programs.hyprland.xwayland.enable = true;
}
