{ pkgs, lib, ... }:
let
  isEnable = false;
in
lib.mkIf (isEnable) {
  environment.systemPackages = with pkgs; [
    yaml-language-server
  ];
}
