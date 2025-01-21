{ lib, ... }:
{
  language = {
    name = "nix";
    language-servers = [ "nix" ];
    indent = {
      tab-width = 2;
      unit = " ";
    };
    formatter = {
      command = "nixfmt";
    };
  };
  server = {
    command = "nil";
    args = [ "--stdio" ];
    scope = "source.nix";
  };
}
