{ ... }:
{
  global = {
    lsp = [
      "scls"
      # "helix-gpt"
    ];
  };
  java = true;
  php = true;
  go = true;
  js = true;
  ts = true;
  rust = true;
  docker = true;
  cpp = false;
  nix = true;
  yaml = true;
  kubernetes = false;
  json = true;
  css = true;
  html = true;
  markdown = true;
  helix-gpt = true;
  scls = true; # Simple Completion Language Server, a autocomplete for plain text from buffer
  sql = true; # require scls enable
  env = true; # require scls enable
  svelte = true;
  astro = true;
  nginx = true;
}
