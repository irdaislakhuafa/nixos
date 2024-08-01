{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    polkit
  ];

  security.polkit.enable = true;
  security.polkit.debug = true;
  security.polkit.adminIdentities = [
    "unix-user:${config.users.users.i.name}"
    "unix-group:${config.users.users.i.group}"
  ];
  programs._1password-gui.polkitPolicyOwners = [
    "${config.users.users.i.name}"
  ];
}
