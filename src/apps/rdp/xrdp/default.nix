{ pkgs, lib, ... }:
let
  isEnable = false;
in
lib.mkIf (isEnable) {
  environment.systemPackages = with pkgs; [ xrdp ];
  services.xrdp.audio.enable = true;
}
