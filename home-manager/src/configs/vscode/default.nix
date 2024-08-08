{ ... }: {
  home.file.".config/code-flags.conf" = {
    enable = true;
    text = ''--ozone-platform=wayland'';
  };
}
