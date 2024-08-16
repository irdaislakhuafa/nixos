{ pkgs, ... }:
let
  extraModule = import ./modules/extra.nix { };
  settingsModule = import ./modules/settings.nix { };
  keybindingsModule = import ./modules/keybindings.nix { };
  envModule = import ./modules/env.nix { };
in
{
  home.packages = with pkgs;[
    kitty
  ];

  programs.kitty = {
    enable = true;
    extraConfig = extraModule;
    theme = "Galaxy";
    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.fira-code-nerdfont;
      size = 8;
    };
    shellIntegration = {
      mode = "no-rc";
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    settings = settingsModule;
    keybindings = keybindingsModule;
    environment = envModule;
  };
}
