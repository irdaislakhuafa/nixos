{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  environment.systemPackages = [ pkgs.fd ];
  programs.fish = {
    enable = true;
    shellInit = ''
      set -x TERM xterm-256color
    '';
  };
}
