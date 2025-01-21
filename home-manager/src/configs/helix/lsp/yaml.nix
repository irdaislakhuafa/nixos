{lib, ...}: {
  language = {
    name = "yaml";
    language-servers = [ "yaml" ];
    indent = {
      tab-width = 2;
      unit = " ";
    };
  };
  server = {
    command = "yaml-language-server";
    args = [ "--stdio" ];
    scope = "source.yaml";
  };
}
