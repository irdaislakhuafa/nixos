{ ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
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
