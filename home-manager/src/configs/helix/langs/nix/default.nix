{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.nix;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.nil
    pkgs.nixfmt-rfc-style
  ];

  programs.helix.languages = {
    language = [
      {
        name = "nix";
        language-servers = [
          "nix"
        ] ++ langs.global.lsp;
        indent = {
          tab-width = 2;
          unit = " ";
        };
        formatter = {
          command = "nixfmt";
        };
      }
    ];

    language-server = {
      nix = {
        command = "nil";
        args = [ "--stdio" ];
        scope = "source.nix";
      };
    };
  };
}
