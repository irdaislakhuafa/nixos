{ ... }:
{
  normal = {
    w = ":u";
    f = ":format";
    A-r = [
      ":reload-all"
      ":lsp-restart"
    ];
    A-z = ":toggle-option soft-wrap.enable";
    C-q = ":buffer-close";
    A-ret = [ ":run-shell-command basename $(pwd)" ];
  };
  select = { };
}
