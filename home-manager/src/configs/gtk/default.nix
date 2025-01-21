{ pkgs, ... }:
{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Adwaita-dark";
      package = pkgs.whitesur-gtk-theme;
    };
  };
}
