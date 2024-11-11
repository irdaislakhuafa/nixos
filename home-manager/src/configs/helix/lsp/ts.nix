{ lib, ... }: rec {
  language = {
    name = "javascript";
    roots = [ "package.json" "node_modules" ];
    language-servers = [ "ts" ];
    indent = {
      tab-width = 4;
      unit = " ";
    };
  };
  server = {
    command = "typescript-language-server";
    args = [ "--stdio" ];
    config = {
      provideFormatter = true;
    };
    scope = "source.ts";
  };
}
