{ pkgs, config, lib, ... }:
let
  isEnabled = false;
in
{
  environment.systemPackages = lib.mkIf isEnabled (with pkgs;[
    nvidia-vaapi-driver
  ]);
  boot.kernelModules = lib.mkIf isEnabled [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  hardware.nvidiaOptimus.disable = !isEnabled;
  hardware.nvidia = lib.mkIf isEnabled {
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
  services.xserver.videoDrivers = lib.mkIf isEnabled [ "nvidia" ];
}
