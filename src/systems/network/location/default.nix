{ lib, ... }:
let
  isEnable = false;
in
lib.mkIf (isEnable) {
  services.geoclue2 = {
    enable = true;
    enable3G = true;
    enableCDMA = true;
    enableDemoAgent = true;
    enableModemGPS = true;
    enableNmea = true;
    enableWifi = true;
  };
}
