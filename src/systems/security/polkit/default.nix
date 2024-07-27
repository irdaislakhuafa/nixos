{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    polkit
  ];

  security.polkit.enable = true;
  security.polkit.debug = true;
  security.polkit.adminIdentities = [
    "unix-group:developer"
  ];
  programs._1password-gui.polkitPolicyOwners = [
    "${config.users.users.i.name}"
  ];
}
