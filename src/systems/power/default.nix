{ lib, config, ... }:
{
  services.logind.powerKey = "suspend-then-hibernate";
  services.logind.powerKeyLongPress = "poweroff";
  powerManagement = {
    enable = true;

    # Configure the governor used to regulate the frequency of the available CPUs.
    # Often used values: "ondemand", "powersave", "performance"
    cpuFreqGovernor = "performance";

    resumeCommands = ''
      systemctl restart iwd;
      rfkill unblock wifi;
    '';
    powerDownCommands = ''
      rfkill block all;
    '';

    # SCSI link power management policy. The kernel default is "max_performance".
    # "med_power_with_dipm" is supported by kernel versions 4.15 and newer.
    # Values: null or one of "min_power", "max_performance", "medium_power", "med_power_with_dipm"
    scsiLinkPolicy = "max_performance";
  };
  services.tlp.enable = false;
  services.tlp.settings = lib.mkIf (config.services.tlp.enable) {
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    PLATFORM_PROFILE_ON_BAT = "low-power";
    CPU_BOOST_ON_BAT = 0;
    CPU_HWP_DYN_BOOST_ON_BAT = 0;
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
  };
}
