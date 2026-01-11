{ lib, pkgs, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  environment.systemPackages = with pkgs; [
    bluetuith
  ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = false;
}
