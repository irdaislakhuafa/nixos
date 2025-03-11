{ pkgs, lib, ... }:
let
  isEnable = false;
in
lib.mkIf (isEnable) {
  environment.systemPackages = [ pkgs.rustdesk ];
}
