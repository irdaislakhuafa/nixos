{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];
}
