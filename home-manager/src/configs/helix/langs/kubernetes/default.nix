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
      {
        name = "kubernetes";
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = { };
  };
}
