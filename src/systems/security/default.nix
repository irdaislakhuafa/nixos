{ pkgs, ... }: {
  imports = [
    ./doas/default.nix
    ./sudo/default.nix
    ./polkit/default.nix
    ./gpg/default.nix
    ./keyring/default.nix
  ];
}
