{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
  ];
  imports = [
    ./nvidia/default.nix
  ];
}
