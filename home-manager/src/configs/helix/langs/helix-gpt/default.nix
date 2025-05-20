{ pkgs, lib, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.helix-gpt;
in
lib.mkIf (isEnable) {
  home.packages = [ pkgs.helix-gpt ];
  programs.helix.languages = {
    language-server = {
      helix-gpt = {
        command = "helix-gpt";
        args = ["--copilotApiKey" "API_KEY" "--handler" "HANDLER"];
      };
    };
  };
}
