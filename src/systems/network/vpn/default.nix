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
  environment.systemPackages = [
    vpn-chome
    pkgs.gost # use as proxy to redirect specific connection
    pkgs.sshuttle # redirect all connection over ssh. need to combine with proxychains4 `pc sshuttle --dns -r user@ip -x 22 0/0`
  ];

  # warp vpn
  services.cloudflare-warp.enable = false;
  services.cloudflare-warp.openFirewall = false;

  # chaining proxy from another source
  programs.proxychains.enable = true;
  programs.proxychains.proxyDNS = true; # Enables proxy DNS routing to prevent leaks
  programs.proxychains.chain.type = "dynamic";
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
