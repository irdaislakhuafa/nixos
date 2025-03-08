{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
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
    # useBabelfish = true;
  };
}
