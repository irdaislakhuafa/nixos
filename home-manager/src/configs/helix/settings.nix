{ ... }: {
  theme = "dark_plus";
  editor = {
    line-number = "absolute";
    lsp = {
      display-messages = true;
    };
    auto-format = true;
    auto-save = true;
    cursorline = true;
    cursorcolumn = true;
    statusline = {
      mode.normal = "NORMAL";
      mode.insert = "INSERT";
      mode.select = "SELECT";
      left = [ "mode" "spinner" ];
      center = [ "file-name" ];
      right = [ "diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type" ];
      separator = "│";
    };
  };
  # keys = import ./keys.nix { };
}

