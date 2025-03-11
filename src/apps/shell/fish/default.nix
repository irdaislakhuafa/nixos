{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  environment.systemPackages = [ pkgs.fd ];
  programs.fish = {
    enable = true;
    # vendor = {
    #   config = {
    #     enable = true;
    #   };
    #   completions = {
    #     enable = true;
    #   };
    #   functions = {
    #     enable = true;
    #   };
    # };
  };
}
