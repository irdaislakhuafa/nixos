{
  lib,
  pkgs,
  config,
  ...
}:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.docker-compose-language-service
    pkgs.dockerfile-language-server-nodejs
  ];

  # TODO: fix it later, currently better use default config
  programs.helix.languages = {
    # language = [
    #   {
    #     name = "docker";
    #     roots = [
    #       "Dockerfile"
    #       ".dockerignore"
    #       "docker-compose.yaml"
    #       "docker-compose.yml"
    #     ];
     
    #     language-servers = [
    #       "docker"
    #     "docker-compose"
    #     ];
    #     indent = {
    #       tab-width = 2;
    #       unit = " ";
    #     };
    #   }
    # ];

    # language-server = {
    #   docker = {
    #     command = "docker-langserver";
    #     args = [ ];
    #     scope = "source.dockerfile";
    #   };
    #   docker-compose = {
    #     command = "docker-compose-langserver";
    #     args = [ ];
    #     scope = "source.docker-compose";
    #   };
    # };
  };
}
