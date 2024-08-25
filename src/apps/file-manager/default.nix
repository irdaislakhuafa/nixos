{ pkgs, lib, config, ... }: {
  environment.systemPackages = with pkgs;[
    glow
    file
    exiftool
    p7zip
  ];
  programs.yazi = rec{
    enable = true;
    settings.yazi = {
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
        edit-text = [{ run = ''nvim "$@"''; desc = "Edit with NVIM"; block = true; }];
        play-mm = [{ run = ''mpv "$@"''; desc = "Play with MPV"; orphan = true; }];
        view-md = [{ run = ''glow -p "$@"''; desc = "View with Glow"; block = true; }];
        open = [{ run = ''xdg-open "$@"''; desc = "Open with XDG"; orphan = true; }];
        view-img = [{ run = ''imv "$@"''; desc = "View Image with IMV"; orphan = true; }];
      };
      open = {
        rules = [
          { mime = "text/*"; use = [ "edit-text" ]; }
          { mime = "video/*"; use = [ "play-mm" ]; }
          { mime = "image/*"; use = [ "view-img" ]; }

          # json
          { name = "*.json"; use = [ "edit-text" ]; }

          # golang
          { name = "*.go"; use = [ "edit-text" ]; }
          { name = "*.mod"; use = [ "edit-text" ]; }
          { name = "*.sum"; use = [ "edit-text" ]; }

          # html and css
          { name = "*.html"; use = [ "edit-text" ]; }
          { name = "*.css"; use = [ "edit-text" ]; }

          # js
          { name = "*.js"; use = [ "edit-text" ]; }

          # markdown
          { name = "*.md"; use = [ "view-md" "edit-text" ]; }
        ];
      };
    };
  };
}
