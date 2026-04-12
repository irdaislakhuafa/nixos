{ pkgs, lib, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.typos;
in
lib.mkIf (true) {
  home.packages = [
    pkgs.typos-lsp
  ];

  programs.helix.languages = {
    language-server = {
      typos = {
        command = "typos-lsp";
        config = {
          # How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
          # Defaults to Info.
          diagnosticSeverity = "Warning";
        };
      };
    };
  };
}
