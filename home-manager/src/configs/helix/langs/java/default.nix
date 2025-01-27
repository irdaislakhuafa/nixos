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
    pkgs.jdt-language-server
    pkgs.spring-boot-cli
  ];

  programs.helix.languages = {
    language = [
      {
        name = "java";
        language-servers = [ "java" ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      java = {
        command = "jdtls";
        args = [ "--stdio" ];
        scope = "source.java";
      };
    };
  };
}
