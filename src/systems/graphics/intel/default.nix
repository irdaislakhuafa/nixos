{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  hardware.intel-gpu-tools.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt # enable qsv
    intel-compute-runtime
  ];
  boot.kernelParams = [ "i915.enable_guc=3" ];
}
