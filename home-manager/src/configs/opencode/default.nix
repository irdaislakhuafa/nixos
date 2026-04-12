{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  home.packages = [ pkgs.opencode ];
  home.file.".config/opencode/opencode.json" = {
    enable = true;
    text = builtins.readFile ./config/opencode.json;
  };
}
