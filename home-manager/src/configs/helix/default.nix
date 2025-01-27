{ ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = false;
    ignores = [ ];
    languages = {
      language = [ ];
      language-server = { };
    };
    settings = import ./settings.nix { };
    themes = import ./themes.nix { };
  };

  imports = import ../../../../importer.nix {
    dir = builtins.toPath ./langs;
  };
}
