{ config, ... }:
{
  zramSwap = {
    enable = true;
    priority = -1; # lower value is high priority
    # memoryMax = (1024 * 1024 * 1024 * 20); # in bytes
    algorithm = "zstd";
    swapDevices = 1;
    memoryPercent = 300;
  };
  services.zram-generator.enable = true;
  systemd.oomd.enable = true;
  systemd.oomd.enableRootSlice = config.systemd.oomd.enable;
  systemd.oomd.enableSystemSlice = config.systemd.oomd.enable;
  systemd.oomd.enableUserSlices = config.systemd.oomd.enable;
  # systemd.oomd.extraConfig = {
  #   OOM = {
  #     # Trigger if memory pressure is high for only 10 seconds
  #     DefaultMemoryPressureDurationSec = "10s";
  #     # Trigger when memory pressure hits 30% (lower is faster)
  #     DefaultMemoryPressureLimitPercent = "30%";
  #     # Trigger when swap is 50% used
  #     SwapUsedLimitPercent = "50%";
  #   };
  #   Service = {
  #     # Kill this service immediately if its cgroup pressure is high
  #     ManagedOOMMemoryPressure = "kill";
  #     # Optional: Make sure this process is considered for killing
  #     OOMScoreAdjust = 1000;
  #   };
  # };
  services.earlyoom = {
    enable = false;
    enableNotifications = true;
    enableDebugInfo = true;
    freeMemThreshold = 30; # Minimum available memory (in percent).
    freeSwapThreshold = 30; # Minimum free swap space (in percent) before sending SIGTERM.
    extraArgs = [
      "-g"
      "-r 3" # report memory each 3s
    ];
  };
}
