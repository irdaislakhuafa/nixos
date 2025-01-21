{ pkgs, ... }: {
  imports = import ../../importer.nix { dir = builtins.toPath ./.; };
  system.copySystemConfiguration = false;
  system.stateVersion = "current";
}
