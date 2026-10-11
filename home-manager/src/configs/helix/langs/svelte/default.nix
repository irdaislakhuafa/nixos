{ lib, pkgs, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.svelte;

in
lib.mkIf (isEnable) {
  home.packages = [ pkgs.svelte-language-server ];

}
