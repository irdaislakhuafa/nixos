{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    gnome-keyring
    libgnome-keyring
    seahorse
  ];
  services.gnome.gnome-keyring.enable = true;
}
