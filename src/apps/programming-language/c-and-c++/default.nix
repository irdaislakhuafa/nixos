{ pkgs, lib, ... }:
let
  isEnable = false;
in
lib.mkIf (isEnable) {
  environment.systemPackages = with pkgs; [
    gcc
    clang-tools
  ];
}
