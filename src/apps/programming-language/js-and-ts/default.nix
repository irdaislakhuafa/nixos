{ pkgs, lib, ... }:
let
  isEnable = false;
in
lib.mkIf (isEnable) rec {
  environment.systemPackages = with pkgs; [
    typescript-language-server
    bun
  ];
}
