{ lib, pkgs, ... }:
let
  isEnable = true;

  # chrome with chaining proxy
  vpn-chome = (
    pkgs.writeShellScriptBin "vpn-chrome" ''
      google-chrome-stable \
        --proxy-server="socks5://127.0.0.1:1080" \
        --user-data-dir="/tmp/bri-profile" \
        $@
    ''
  );
in
lib.mkIf (isEnable) {
  environment.systemPackages = [ vpn-chome pkgs.gost ];

  # warp vpn
  services.cloudflare-warp.enable = true;
  services.cloudflare-warp.openFirewall = true;

  # chaining proxy from another source
  programs.proxychains.enable = true;
  programs.proxychains.proxies = {
    bri-http = {
      enable = false;
      type = "http";
      host = "127.0.0.1";
      port = 8080;
    };
    bri-socks = {
      enable = true;
      type = "socks5";
      host = "127.0.0.1";
      port = 1080;
    };
  };
  environment.shellAliases = {
    pc = "proxychains4";
  };
}
