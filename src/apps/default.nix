{config, pkgs, lib, ... }:
{
  imports = [
    ./d2/default.nix
    ./tree/default.nix
    ./nix/default.nix
    ./zellij/default.nix
    ./pfetch/default.nix
    ./gh/default.nix
  ];
}
