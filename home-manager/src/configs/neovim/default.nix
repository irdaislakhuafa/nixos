{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf isEnable {
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [ ];
  };
}
