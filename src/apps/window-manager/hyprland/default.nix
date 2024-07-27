{ lib, pkgs, config, ... }:
let
  isEnableAutoStart = true;
in
rec {
  environment.systemPackages = with pkgs;[
    hyprland
    waybar
    xdg-desktop-portal-hyprland
    polkit
    rofi-wayland
    hyprpaper
  ];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.waybar.enable = true;

  programs.zsh.loginShellInit = lib.mkIf isEnableAutoStart ''
    CURRENT_TTY=$(tty)
    if [ "$CURRENT_TTY" = "/dev/tty1" ]; then
      ${pkgs.hyprland}/bin/Hyprland
    fi
  '';
}
