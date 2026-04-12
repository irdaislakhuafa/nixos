{ lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  # warp vpn
  services.cloudflare-warp.enable = true;
  services.cloudflare-warp.openFirewall = true;

  # chaining proxy from another source
  programs.proxychains.enable = true;
  programs.proxychains.proxies = {
    bri-http = {
      enable = false;
      type = "http";
      host = "192.168.170.246";
      port = 8080;
    };
    bri-socks = {
      enable = true;
      type = "socks5";
      # host = "192.168.170.246";
      host = "127.0.0.1";
      port = 1080;
    };
  };
}
