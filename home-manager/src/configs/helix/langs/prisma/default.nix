{ pkgs, lib, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.prisma;

  fetchedPinnedPkgs = builtins.fetchGit rec {
    url = "https://github.com/NixOS/nixpkgs";
    rev = "da289b19d0cbe59c3d3a060bcc990dc955124c64";
    name = "prisma-language-server-${rev}";
  };
  pinnedPkgs = import fetchedPinnedPkgs {
    inherit (pkgs) system config;
  };
in
lib.mkIf (isEnable) {
  home.packages = [
    pinnedPkgs.prisma-language-server
  ];

  programs.helix.languages = {
    language = [
      {
        name = "prisma";
        scope = "source.prisma";
        injection-regex = "prisma";
        file-types = [ "prisma" ];
        roots = [ "package.json" ];
        comment-token = "//";
        language-servers = [
          "prisma-language-server"
        ] ++ langs.global.lsp;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
      }
    ];
    language-server = {
      prisma-language-server = {
        command = "prisma-language-server";
        args = [ "--stdio" ];
        config.prisma.enableDiagnostics = true;
      };
    };
  };
}
