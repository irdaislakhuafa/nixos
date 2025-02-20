{ ... }:
{
  programs.home-manager.enable = true;

  home.enableNixpkgsReleaseCheck = false;
  imports = import ../importer.nix { dir = builtins.toPath ./src; };
}
