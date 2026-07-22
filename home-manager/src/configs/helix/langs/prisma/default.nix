{ pkgs, lib, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.prisma;
  fetchedPinnedPkgs = builtins.fetchTarball rec {
    url = "https://github.com/NixOS/nixpkgs/archive/da289b19d0cbe59c3d3a060bcc990dc955124c64.tar.gz";
    sha256 = "0yw56b5xvf4vjbn6ss5g7ibnrsadmy10qhggw5h0ncx2klv7827m";
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
