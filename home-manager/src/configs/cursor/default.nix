{ pkgs, ... }: {
  home.packages = with pkgs;[
    afterglow-cursors-recolored
    oreo-cursors-plus
  ];
  home.pointerCursor = rec {
    name = "Afterglow-Recolored-Gruvbox-Black";
    gtk = {
      enable = true;
    };
    package = pkgs.afterglow-cursors-recolored;
    size = 20;
    x11 = {
      defaultCursor = name;
      enable = true;
    };
  };
}
