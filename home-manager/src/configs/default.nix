{ config, pkgs, ... }: {
  imports = [
    ./hyprland/default.nix
    ./git/default.nix
    ./cursor/default.nix
    ./kitty/default.nix
    ./vscode/default.nix
    ./waybar/default.nix
    ./rofi/default.nix
    ./taskwarrior/default.nix
  ];
}
