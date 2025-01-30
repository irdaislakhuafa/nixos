{ ... }:
{
  zramSwap = {
    enable = true;
    priority = -1; # lower value is high priority
    memoryMax = (1024 * 1024 * 1024 * 20); # in bytes
    algorithm = "zstd";
    swapDevices = 1;
    memoryPercent = 100;
  };
  services.zram-generator.enable = true;
  systemd.oomd.enable = false;
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
