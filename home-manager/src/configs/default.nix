{ config, pkgs, ... }: {
  imports = [
    ./hyprland/default.nix
    ./git/default.nix
    ./cursor/default.nix
  ];
}
