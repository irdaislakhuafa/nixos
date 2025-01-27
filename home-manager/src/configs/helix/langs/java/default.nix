{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../langs.nix { };
  isEnable = langs.java;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.jdt-language-server
    pkgs.spring-boot-cli
    pkgs.lombok
    pkgs.jetbrains.jdk
  ];

  programs.helix.languages = {
    language = [
      {
        name = "java";
        roots = [
          "pom.xml"
          "build.gradle"
        ];
        language-servers = [ "jdtls" ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      jdtls = {
        command = "jdtls";
        args = [
          "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
        ];
        scope = "source.java";
        config = {
          java = {
            inlayHints = {
              parameterNames.enabled = "all";
            };
          };
        };
      };
    };
  };
}
