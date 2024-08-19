{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-search-cli
    direnv
    nix-direnv
    nixpkgs-fmt
  ];
  nix.settings = { };
}
