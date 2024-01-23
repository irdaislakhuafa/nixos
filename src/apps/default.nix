{config, pkgs, lib, ... }:
{
  imports = [
    ./lsd/default.nix
    ./d2/default.nix
    ./tree/default.nix
    ./nix/default.nix
    ./zellij/default.nix
    ./pfetch/default.nix
    ./git/default.nix
    ./docker/default.nix
    ./neovim/default.nix
  ];
}
