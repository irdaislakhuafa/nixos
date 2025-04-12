{
  lib,
  pkgs,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.java;
  features = {
    lombok = {
      enable = true;
      args = [ "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar" ];
      pkgs = [ pkgs.lombok ];
    };
    spring-boot-cli = {
      enable = true;
      pkgs = [ pkgs.spring-boot-cli ];
    };
    javafx = {
      enable = false;
      args = [
        "--jvm-arg=--module-path=${pkgs.javaPackages.openjfx23}/modules/"
        "--jvm-arg=--add-modules=javafx.controls,javafx.fxml"
      ];
      pkgs = [ pkgs.javaPackages.openjfx23 ];
    };
  };
in
lib.mkIf (isEnable) {
  home.packages =
    [
      pkgs.jdt-language-server
      pkgs.graalvmPackages.graalvm-ce-musl
    ]
    ++ (if (features.lombok.enable) then features.lombok.pkgs else [ ])
    ++ (if (features.spring-boot-cli.enable) then features.spring-boot-cli.pkgs else [ ])
    ++ (if (features.javafx.enable) then features.javafx.pkgs else [ ]);

  programs.helix.languages = {
    language = [
      {
        name = "java";
        roots = [
          "pom.xml"
          "build.gradle"
        ];
        language-servers = [
          "jdtls"
          "scls"
        ];
        indent = {
          tab-width = 4;
          unit = " ";
        };
      }
    ];

    language-server = {
      jdtls = {
        command = "jdtls";
        args =
          [ "--enable-preview" ]
          ++ (if (features.lombok.enable) then features.lombok.args else [ ])
          ++ (if (features.javafx.enable) then features.javafx.args else [ ]);
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
