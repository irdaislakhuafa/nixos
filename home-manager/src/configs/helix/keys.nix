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
    C-ret = [ ":run-shell-command echo \"%sh{git blame -L %{cursor_line},+1 %{buffer_name} | cut -d' ' -f1-8}\"" ];
  };
  select = { };
}
