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
    pkgs.helm-ls
  ];

  programs.helix.languages = {
    language = [
      # {
      #   name = "kubernetes";
      #   file-types = ["yaml" "yml"];
      #   language-servers = [ "kubernetes" ];
      #   indent = {
      #     tab-width = 2;
      #     unit = " ";
      #   };
      # }
    ];

    language-server = {
      # kubernetes = {
      #   command = "helm_ls";
      #   args = [ "serve" ];
      #   scope = "source.yaml";
      # };
    };
  };
}
