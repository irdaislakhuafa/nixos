{ pkgs, ... }: {
  imports = [
    ./doas/default.nix
    ./sudo/default.nix
    ./polkit/default.nix
  ];
}
