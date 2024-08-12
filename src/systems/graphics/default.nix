{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    brightnessctl
    libva-utils
  ];

  imports = [
    ./nvidia/default.nix
    ./x11/default.nix
    ./intel/default.nix
  ];

  hardware.graphics = {
    enable = true;
  };
  services.xserver.enable = false;
}
