{ config, pkgs, lib, ... }:
{
  imports = [
    ./cli/default.nix
    ./shell/default.nix
    ./ide/default.nix
    ./container/default.nix
    ./web-browser/default.nix
    ./package-manager/default.nix
    ./terminal/default.nix
    ./window-manager/default.nix
  ];
}
