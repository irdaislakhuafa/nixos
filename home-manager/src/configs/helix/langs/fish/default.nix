{
  lib,
  pkgs,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.fish;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.fish
    pkgs.fish-lsp
  ];

  programs.helix.languages = {
    language = [
      {
        name = "fish";
        scope = "source.fish";
        injection-regex = "fish";
        file-types = [ "fish" ];
        shebangs = [ "fish" ];
        comment-token = "#";
        language-servers = [ "fish-lsp" ] ++ langs.global.lsp;
        indent = {
          tab-width = 4;
          unit = "    ";
        };
        auto-format = true;
        formatter = {
          command = "fish_indent";
        };
      }
    ];
    language-servers = {
      fish-lsp = {
        command = "fish-lsp";
        args = [ "start" ];
      };
    };
  };
}
