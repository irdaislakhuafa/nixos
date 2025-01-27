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
    pkgs.yaml-language-server
  ];

  programs.helix.languages = {
    language = [
      {
        name = "yaml";
        language-servers = [ "yaml" ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      yaml = {
        command = "yaml-language-server";
        args = [ "--stdio" ];
        scope = "source.yaml";
      };
    };
  };
}
