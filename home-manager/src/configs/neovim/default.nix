{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf isEnable {
  programs.neovim.defaultEditor = true;
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;
}
