{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) rec {
  environment.systemPackages = with pkgs; [
    typescript-language-server
    bun
  ];
}
