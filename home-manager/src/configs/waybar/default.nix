{ pkgs, ... }:
let
  styles = import ./styles.nix { };
  activeStyle = styles.glassy_night_minimal;
in
{
  home.packages = with pkgs; [
    waybar
  ];
  programs.waybar.enable = true;
  programs.waybar.style = ''${builtins.readFile activeStyle}'';
  programs.waybar.settings = import ./configs/settings.nix { inherit pkgs; };
}
