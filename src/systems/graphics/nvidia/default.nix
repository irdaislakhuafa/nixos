{ pkgs, config, lib, ... }:
let
  isEnabled = false;
in
lib.mkIf (isEnabled) {
  environment.systemPackages = with pkgs;[
    nvidia-vaapi-driver
  ];
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  hardware.nvidiaOptimus.disable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement = {
      enable = isEnabled;
      finegrained = false;
    };
    nvidiaSettings = isEnabled;
    open = false;
    nvidiaPersistenced = isEnabled;
    dynamicBoost = { enable = false; };
    modesetting = { enable = isEnabled; };
    prime = {
      # offload = {
      #   enable = isEnabled;
      #   enableOffloadCmd = isEnabled;
      # };
      sync = { enable = isEnabled; };
      nvidiaBusId = "PCI:02:00:0";
      intelBusId = "PCI:00:02:0";
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
