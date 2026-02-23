{
  lib,
  pkgs,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.sonarlint;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.sonarlint-ls
  ];

  programs.helix.languages = {
    sonarlint = {
      command = "sonarlint-ls";
    };
  };
}
