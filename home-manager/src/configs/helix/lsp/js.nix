{ lib, ... }: {
  language = {
    name = "javascript";
    roots = [ "package.json" "node_modules" ];
    language-servers = [ "js" ];
    auto-format = true;
  };
  server = {
    command = "typescript-language-server";
    args = [ "--stdio" ];
    config = {
      provideFormatter = true;
    };
    scope = "source.js";
  };
}