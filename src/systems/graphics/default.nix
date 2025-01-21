{ pkgs, ... }: {
  imports = import ../../../importer.nix { dir = builtins.toPath ./.; };
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    brightnessctl
    libva-utils
  ];


  hardware.graphics = {
    enable = true;
  };
  services.xserver.enable = false;
}
