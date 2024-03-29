{ pkgs, ... }: {
  imports = [
    ./doas/default.nix
    ./sudo/default.nix
  ];
}
