{ ... }:
{
  theme = "dark_plus";
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
      character = "│"; # ❙, │, ┆
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
      display-progress-messages = true;
    };
    auto-format = true;
    auto-save = {
      focus-lost = true;
      after-delay = {
        enable = true;
        timeout = 3000;
      };
    };
    auto-completion = true;
    idle-timeout = 250;
    preview-completion-insert = true;
    auto-info = true;
    true-color = true;
    color-modes = true;
    default-line-ending = "native";
    indent-heuristic = "simple";
    cursorline = true;
    cursorcolumn = true;
    statusline = {
      mode.normal = "NORMAL";
      mode.insert = "INSERT";
      mode.select = "SELECT";
      left = [
        "mode"
        "spinner"
      ];
      center = [ "file-name" ];
      right = [
        "file-modification-indicator"
        "read-only-indicator"
        "diagnostics"
        "selections"
        "position"
        "file-encoding"
        "file-line-ending"
        "file-type"
      ];
      separator = "│";
    };
    end-of-line-diagnostics = "hint";
    inline-diagnostics = {
      cursor-line = "warning";
    };
    bufferline = "multiple";
    popup-border = "all";
    completion-trigger-len = 1;
    file-picker = {
      hidden = false; # ignore hidden files
    };
  };
  keys = import ./keys.nix { };
}
