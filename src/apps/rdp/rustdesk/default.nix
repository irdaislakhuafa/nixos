{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  environment.systemPackages = [ pkgs.rustdesk ];
}
