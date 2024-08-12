{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    intel-gpu-tools
  ];
  hardware.intel-gpu-tools.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.graphics.extraPackages = with pkgs;[
    intel-media-driver
    intel-media-sdk
    intel-vaapi-driver
  ];
}
