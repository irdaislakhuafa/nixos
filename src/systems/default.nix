{ pkgs, ... }: {
  imports = [
    ./boot/default.nix
    ./env/default.nix
    ./users/default.nix
    ./timezone/default.nix
    ./nixpkgs/default.nix
    ./hardware/default.nix
    ./security/default.nix
    ./network/default.nix
    ./ssh/default.nix
    ./disks/default.nix
    ./graphics/default.nix
    ./desktop/default.nix
    ./memory/default.nix
    ./power/default.nix
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "current"; # Did you read the comment?
}
