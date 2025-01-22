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
    # wl-mirror
    wl-clipboard-x11
    wl-clipboard
    hyprlock
    swaybg
    hypridle
    # waypipe
    hyprnotify
    hyprpicker
    hyprshot
    wl-screenrec
    # wf-recorder
    # clipboard-jh
    yank
    clipse
    grim
    slurp
    woomer
  ];

  programs.hyprlock.enable = isEnableAutoStart;
  programs.hyprland.enable = isEnableAutoStart;
  programs.hyprland.xwayland.enable = isEnableAutoStart;
  programs.waybar.enable = isEnableAutoStart;
  services.hypridle.enable = isEnableAutoStart;
  programs.hyprland.systemd.setPath.enable = isEnableAutoStart;

  programs.zsh.loginShellInit = lib.mkIf isEnableAutoStart ''
    CURRENT_TTY=$(tty)
    if [ "$CURRENT_TTY" = "/dev/tty1" ]; then
      ${pkgs.hyprland}/bin/Hyprland
    fi
  '';
}
