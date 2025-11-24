{ pkgs, ... }:
let
  fetchedPinnedPkgs = builtins.fetchGit rec {
    url = "https://github.com/NixOS/nixpkgs";
    rev = "da289b19d0cbe59c3d3a060bcc990dc955124c64";
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

  home.file.".config/helix/themes/ariake_dark.toml" = {
    enable = true;
    text = builtins.readFile ./themes/ariake_dark.toml;
  };
  home.file.".config/helix/themes/ariake_dark_transparent.toml" = {
    enable = true;
    text = builtins.readFile ./themes/ariake_dark_transparent.toml;
  };

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
