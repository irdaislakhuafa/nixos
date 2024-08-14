{ pkgs, ... }: {
  imports = (
    let
      dirs = builtins.filter (f: f != "default.nix") (builtins.attrNames (builtins.readDir ./.));
    in
    builtins.map (dir: "${builtins.toPath ./${dir}}" + "/default.nix") dirs
  );

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "current"; # Did you read the comment?
}
