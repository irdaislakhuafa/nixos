{ pkgs, ... }: {
  imports = [
    ./alacritty/default.nix
    ./kitty/default.nix
  ];
}
