{
  lib,
  pkgs,
  config,
  ...
}:
let
  isEnable = false;
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
        args = [
          "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
        ];
        scope = "source.java";
      };
    };
  };
}
