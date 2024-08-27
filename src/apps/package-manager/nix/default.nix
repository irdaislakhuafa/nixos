{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-search-cli
    direnv
    nix-direnv
    nixpkgs-fmt
    nix-inspect
  ];
  nix.settings = {
    extra-experimental-features = [ "flakes" "nix-command" ];
  };
}
