{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    ueberzugpp
    poppler_utils
    ffmpegthumbnailer
    zip
    unzip
    unrar
    highlight
  ];
  programs.ranger = {
    enable = true;
    settings = {
      unicode_ellipsis = true;
      preview_images = true;
      preview_images_method = "ueberzug";
      draw_borders = true;
      preview_script = "${config.home.homeDirectory}/.config/ranger/scope.sh";
    };
  };
  home.file.".config/ranger/scope.sh".source = ./configs/scope.sh;
}
