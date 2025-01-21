{ ... }: {
  zramSwap = {
    enable = true;
    priority = -1; # lower value is high priority
    memoryMax = (1024 * 1024 * 1024 * 20); # in bytes
    algorithm = "zstd";
    swapDevices = 1;
    memoryPercent = 100;
  };
  services.zram-generator.enable = true;
}
