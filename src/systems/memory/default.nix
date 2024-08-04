{ ... }: {
  zramSwap = {
    enable = true;
    priority = 5;
    memoryMax = 21474836480;
    algorithm = "zstd";
    swapDevices = 1;
    memoryPercent = 100;
  };
  services.zram-generator.enable = true;
}
