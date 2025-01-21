{ ... }: {
  services.logind.powerKey = "suspend-then-hibernate";
  services.logind.powerKeyLongPress = "poweroff";
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };
}
