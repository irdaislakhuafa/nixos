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
        args = [
          # github copilot -- get api token with `helix --authCopiot`
          # "--copilotApiKey"
          # "API_KEY"
          # "--handler"
          # "copilot"

          # openai
          # "--openaiKey"
          # "API_KEY"
          # "--handler"
          # "openai"

          # codeium - get api token with `helix --authCodeium`
          "--codeiumApiKey"
          "API_KEY"
          "--handler"
          "codeium"
        ];
      };
    };
  };
}
