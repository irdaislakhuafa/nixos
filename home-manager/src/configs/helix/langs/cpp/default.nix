{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
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
        scope = "source.cpp";
        injection-regex = "cpp";
        file-types = [
          "cc"
          "hh"
          "c++"
          "cpp"
          "hpp"
          "h"
          "ipp"
          "tpp"
          "cxx"
          "hxx"
          "ixx"
          "txx"
          "ino"
          "C"
          "H"
          "cu"
          "cuh"
          "cppm"
          "h++"
          "ii"
          "inl"
          { glob = ".hpp.in"; }
          { glob = ".h.in"; }
        ];
        comment-token = "//";
        block-comment-tokens = {
          start = "/*";
          end = "*/";
        };
        language-servers = [ "clangd" ] ++ langs.global.lsp;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
      }
    ];

    language-server = { };
  };
}
