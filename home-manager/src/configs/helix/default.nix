{ pkgs, ... }:
let
  fetchedPinnedPkgs = builtins.fetchGit rec {
    url = "https://github.com/NixOS/nixpkgs";
    rev = "a87f52e68cb2d4714184e1931320e6d50c9c1866";
    name = "helix-${rev}";
  };
  pinnedPkgs = import fetchedPinnedPkgs {
    inherit (pkgs) system config;
  };
in
{
  home.packages = [
    pkgs.serpl
  ];
  programs.helix = {
    package = pinnedPkgs.helix;
    enable = true;
    defaultEditor = true;
    ignores = [ ];
    languages = {
      language = [ ];
      language-server = { };
    };
    settings = import ./settings.nix { };
    themes = import ./themes.nix { };
  };

  imports = import ../../../../importer.nix {
    dir = builtins.toPath ./langs;
  };
}
