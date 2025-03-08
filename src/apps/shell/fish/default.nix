{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  programs.fish = {
    enable = true;
  };
}
