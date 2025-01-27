{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../langs.nix { };
  isEnable = langs.cpp;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.gcc
    pkgs.clang-tools
  ];

  programs.helix.languages = {
    language = [
      {
        name = "cpp";
        indent = {
          tab-width = 4;
          unit = " ";
        };
      }
    ];

    language-server = { };
  };
}
