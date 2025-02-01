{ ... }: {
  theme = "fleet_dark";
  editor = {
    cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };
    whitespace = {
      render = "all";
    };
    indent-guides = {
      render = true;
      character = "❙";
      skip-levels = 1;
    };
    smart-tab = {
      enable = true;
    };
    line-number = "absolute";
    lsp = {
      enable = true;
      display-messages = true;
      display-inlay-hints = true;
    };
    auto-format = true;
    auto-save = true;
    auto-completion = true;
    idle-timeout = 250;
    preview-completion-insert = true;
    auto-info = true;
    true-color = true;
    color-modes = true;
    default-line-ending  = "native";
    indent-heuristic = "simple";
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
  keys = import ./keys.nix { };
}

