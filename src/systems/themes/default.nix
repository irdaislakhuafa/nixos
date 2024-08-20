{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    mojave-gtk-theme
  ];
  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-theme-name = "Mojave-Dark"
  '';
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = Mojave-Dark
  '';

  gtk.iconCache.enable = true;
}
