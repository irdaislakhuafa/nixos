{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    brightnessctl
  ];
  imports = [
    ./nvidia/default.nix
    ./x11/default.nix
  ];
}
