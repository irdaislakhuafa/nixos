{
  pkgs,
  config,
  lib,
  ...
}:
let
  isEnable = false;
in
lib.mkIf (isEnable) {
  home.packages = with pkgs; [
    glow
    file
    exiftool
    p7zip
  ];
  home.sessionVariables = {
    YAZI_CONFIG_HOME = "${config.home.homeDirectory}/.config/yazi/";
  };
  programs.yazi = rec {
    enable = false;
    enableZshIntegration = enable;
    settings = {
      log = {
        enable = true;
      };
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_dir_first = true;
        sort_reverse = false;
        line_mode = "permissions";
        show_symlink = true;
      };
      opener = {
        edit-text = [
          {
            run = ''nvim "$@"'';
            block = true;
            for = "unix";
          }
        ];
        play-mm = [
          {
            run = ''mpv "$@"'';
            orphan = true;
            for = "unix";
          }
        ];
        view-md = [
          {
            run = ''glow -p "$@"'';
            block = true;
          }
        ];
        open = [
          {
            run = ''xdg-open "$@"'';
            desc = "Open with XDG";
          }
        ];
        view-pdf = [
          {
            run = ''zathura "$@"'';
            desc = ''Open with Zathura'';
            orphan = true;
          }
          {
            run = ''brave "$@"'';
            desc = ''Open with Brave Browser'';
            orphan = true;
          }
        ];

      };
      open = {
        append_rules = [
          {
            mime = "text/*";
            use = [ "edit" ];
          }
          {
            mime = "video/*";
            use = [ "play" ];
          }

          # pdf
          {
            mime = "application/pdf";
            use = [ "view-pdf" ];
          }

          # json
          {
            name = "*.json";
            use = [ "edit" ];
          }

          # golang
          {
            name = "*.go";
            use = [ "edit" ];
          }
          {
            name = "*.mod";
            use = [ "edit" ];
          }
          {
            name = "*.sum";
            use = [ "edit" ];
          }

          # html and css
          {
            name = "*.html";
            use = [ "edit" ];
          }
          {
            name = "*.css";
            use = [ "edit" ];
          }

          # js
          {
            name = "*.js";
            use = [ "edit" ];
          }

          # markdown
          {
            name = "*.md";
            use = [
              "view-md"
              "edit"
            ];
          }
        ];
      };
    };
  };
}
