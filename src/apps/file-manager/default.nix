{
  pkgs,
  lib,
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    glow
    file
    exiftool
    p7zip
    zathura
  ];
  environment.shellAliases = {
    here = "yazi .";
    glow = "glow -w 0";
  };
  programs.yazi = {
    initLua = ./init.lua;
    enable = true;
    settings.yazi = {
      log = {
        enable = true;
      };
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_dir_first = true;
        sort_reverse = false;
        line_mode = "permissions_and_size_and_mtime";
        show_symlink = true;
      };
      opener = {
        edit-text = [
          {
            run = ''nvim "$@"'';
            desc = "Open with NVIM";
            block = true;
          }
          {
            run = ''hx "$@"'';
            desc = "Open with Helix";
            block = true;
          }
          {
            run = ''code "$@"'';
            desc = "Open with VS Code";
            orphan = true;
          }
        ];
        play-mm = [
          {
            run = ''mpv "$@"'';
            desc = "Play with MPV";
            orphan = false;
          }
          {
            run = ''mpv --no-vid "$@"'';
            desc = "Play Audio with MPV";
            orphan = false;
          }
          {
            run = ''mpv --no-vid --loop=yes "$@"'';
            desc = "Play Audio Loop with MPV";
            orphan = false;
          }
        ];
        view-md = [
          {
            run = ''glow -p "$@"'';
            desc = "View with Glow";
            block = true;
          }
        ];
        view-pdf = [
          {
            run = ''zathura "$@"'';
            desc = "View with Zathura";
            orphan = true;
          }
        ];
        open = [
          {
            run = ''xdg-open "$@"'';
            desc = "Open with XDG";
            orphan = true;
          }
        ];
        view-img = [
          {
            run = ''imv "$@"'';
            desc = "View Image with IMV";
            orphan = true;
          }
        ];
        rar = [
          {
            run = ''unrar e "$@"'';
            desc = "Extract to current dir";
            orphan = false;
          }
          {
            run = ''unrar x "$@"'';
            desc = "Extract with full path";
            orphan = false;
          }
          {
            run = ''unrar l "$@" && read'';
            desc = "List files inside rar";
            orphan = false;
            block = true;
          }
          {
            run = ''unrar lb "$@" && read'';
            desc = "List files inside rar (Bare Format)";
            orphan = false;
            block = true;
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            mime = "text/*";
            use = [
              "edit-text"
              "view-md"
            ];
          }
          {
            mime = "video/*";
            use = [ "play-mm" ];
          }
          {
            mime = "image/*";
            use = [ "view-img" ];
          }

          # json
          {
            name = "*.json";
            use = [ "edit-text" ];
          }

          # golang
          {
            name = "*.go";
            use = [ "edit-text" ];
          }
          {
            name = "*.mod";
            use = [ "edit-text" ];
          }
          {
            name = "*.sum";
            use = [ "edit-text" ];
          }

          # html and css
          {
            name = "*.html";
            use = [ "edit-text" ];
          }
          {
            name = "*.css";
            use = [ "edit-text" ];
          }

          # js
          {
            name = "*.js";
            use = [ "edit-text" ];
          }
          {
            mime = "application/javascript";
            use = [ "edit-text" ];
          }

          # markdown
          {
            name = "*.md";
            use = [
              "view-md"
              "edit-text"
            ];
          }

          # directory
          {
            mime = "inode/directory";
            use = [ "edit-text" ];
          }

          # rar files
          {
            mime = "application/x-rar";
            use = [
              "rar"
              "play-mm"
            ];
          }

          # pdf files
          {
            mime = "application/pdf";
            use = [ "view-pdf" ];
          }
        ];
      };
    };
  };
}
