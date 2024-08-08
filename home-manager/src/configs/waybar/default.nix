{ pkgs, lib, ... }: rec {
  home.packages = with pkgs;[
    waybar
  ];
  programs.waybar.enable = true;
  programs.waybar.style = ''${builtins.readFile ./configs/style.css}'';
  programs.waybar.settings = import ./configs/settings.nix { inherit pkgs; };
}
