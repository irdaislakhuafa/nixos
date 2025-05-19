{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.docker;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.docker-compose-language-service
    pkgs.dockerfile-language-server-nodejs
  ];

  # TODO: fix it later, currently better use default config
  programs.helix.languages = {
    language = [
      {
        name = "dockerfile";
        scope = "source.dockerfile";
        injection-regex = "docker|dockerfile";
        roots = [
          "Dockerfile"
          "Containerfile"
        ];
        file-types = [
          "Dockerfile"
          { glob = "Dockerfile"; }
          { glob = "Dockerfile.*"; }
          "dockerfile"
          { glob = "dockerfile"; }
          { glob = "dockerfile.*"; }
          "Containerfile"
          { glob = "Containerfile"; }
          { glob = "Containerfile.*"; }
          "containerfile"
          { glob = "containerfile"; }
          { glob = "containerfile.*"; }
        ];
        comment-token = "#";
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        language-servers = [ "docker-langserver" ] ++ langs.global.lsp;
      }
      {
        name = "docker-compose";
        scope = "source.yaml.docker-compose";
        roots = [
          "docker-compose.yaml"
          "docker-compose.yml"
        ];
        language-servers = [
          "docker-compose-langserver"
          "yaml-language-server"
        ] ++ langs.global.lsp;
        file-types = [
          { glob = "docker-compose.yaml"; }
          { glob = "docker-compose.yml"; }
        ];
        comment-token = "#";
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        grammar = "yaml";
      }
    ];

    language-server = {
      docker-langserver = {
        command = "docker-langserver";
        args = [ "--stdio" ];
      };
      docker-compose-langserver = {
        command = "docker-compose-langserver";
        args = [ "--stdio" ];
      };
    };
  };
}
