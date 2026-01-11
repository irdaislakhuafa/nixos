{ lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  services.cloudflare-warp.enable = true;
  services.cloudflare-warp.openFirewall = true;
}
