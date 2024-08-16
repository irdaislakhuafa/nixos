{ pkgs, ... }: {
  home.packages = with pkgs;[
    glow
    file
    exiftool
  ];
  programs.yazi = rec{
    enable = true;
    enableZshIntegration = enable;
    settings = {
      log = { enable = true; };
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
        edit-text = [{ run = ''nvim "$@"''; block = true; for = "unix"; }];
        play-mm = [{ run = ''mpv "$@"''; orphan = true; for = "unix"; }];
        view-md = [{ run = ''glow -p "$@"''; block = true; }];
        open = [{ run = ''xdg-open "$@"''; desc = "Open with XDG"; }];
      };
      open = {
        append_rules = [
          { mime = "text/*"; use = [ "edit" ]; }
          { mime = "video/*"; use = [ "play" ]; }

          # json
          { name = "*.json"; use = [ "edit" ]; }

          # golang
          { name = "*.go"; use = [ "edit" ]; }
          { name = "*.mod"; use = [ "edit" ]; }
          { name = "*.sum"; use = [ "edit" ]; }

          # html and css
          { name = "*.html"; use = [ "edit" ]; }
          { name = "*.css"; use = [ "edit" ]; }

          # js
          { name = "*.js"; use = [ "edit" ]; }

          # markdown
          { name = "*.md"; use = [ "view-md" "edit" ]; }
        ];
      };
    };
  };
}
