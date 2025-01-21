{ pkgs, config, lib, ... }:
let
  isEnabled = false;
in
if (isEnabled) then {
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
} else {
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';

  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
}
