{ pkgs, ... }: {
  hardware.nvidiaOptimus.disable = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.nvidiaSettings = true;
}
