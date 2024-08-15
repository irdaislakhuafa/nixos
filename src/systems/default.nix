{ pkgs, ... }: {
  imports = import ../../importer.nix { dir = builtins.toPath ./.; };
  system.copySystemConfiguration = true;
  system.stateVersion = "current";
}
