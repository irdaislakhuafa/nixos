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
        edit-text = [
          { run = ''nvim "$@"''; desc = "Edit with NVIM"; block = true; }
          { run = ''code "$@"''; desc = "Open with VS Code"; orphan = true; }
        ];
        play-mm = [
          { run = ''mpv "$@"''; desc = "Play with MPV"; orphan = true; }
          { run = ''mpv --no-vid "$@"''; desc = "Play Audio with MPV"; orphan = false; }
          { run = ''mpv --no-vid --loop=yes "$@"''; desc = "Play Audio Loop with MPV"; orphan = false; }
        ];
        view-md = [{ run = ''glow -p "$@"''; desc = "View with Glow"; block = true; }];
        open = [{ run = ''xdg-open "$@"''; desc = "Open with XDG"; orphan = true; }];
        view-img = [{ run = ''imv "$@"''; desc = "View Image with IMV"; orphan = true; }];
      };
      open = {
        prepend_rules = [
          { mime = "text/*"; use = [ "edit-text" "view-md" ]; }
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

          # directory
          { mime = "inode/directory"; use = [ "edit-text" ]; }
        ];
      };
    };
  };
}
