{
  pkgs,
  config,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    iwd
    # openvpn
    wirelesstools
    bluetuith
    # impala
    inputs.iwmenu.packages.${pkgs.system}.default
  ];

  networking.hostName = "developer";
  networking.useNetworkd = true;
  networking.useDHCP = true;
  networking.domain = "~.";
  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
  ];

  networking.wireless.iwd = {
    package = pkgs.iwd;
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
      Network = rec {
        EnableIPv6 = true;
        EnableDHCPv6 = EnableIPv6;
        RoutePriorityOffset = 300;
        NameResolvingService = "systemd";
      };
      General = {
        UseDefaultInterface = false;
        IgnorePeerSignalStrength = false;
        EnableNetworkConfiguration = true;
        DisablePowerSave = true;
      };
    };
  };
  services.resolved = {
    enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = false;
  services.pulseaudio.extraModules = with pkgs; [
    pulseaudio-modules-bt
  ];

  services.haveged.enable = false;
  # systemd.services.haveged.unitConfig.ConditionKernelVersion = lib.mkIf (config.services.haveged.enable) (lib.mkForce ">5.6");

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.startsWith("net.connman.iwd") && subject.isInGroup("${config.users.users.i.group}")) {
        return polkit.Result.YES;
      }
    })
  '';

  networking.wireless.enable = false;
  networking.networkmanager.enable = false;

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ ];
    allowedTCPPortRanges = [ ];
    allowedUDPPorts = [ ];
    allowedUDPPortRanges = [
      # Chromecast client-to-control communication
      {
        from = 32768;
        to = 61000;
      }
    ];
  };
}
