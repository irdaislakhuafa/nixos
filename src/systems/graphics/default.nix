{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nvtop
  ];
  imports = [
    ./nvidia/default.nix
  ];
}
