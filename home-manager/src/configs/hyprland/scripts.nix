{ pkgs, ... }:
let
  builder = {
    fish =
      { name, path }:
      pkgs.writeTextFile {
        inherit name;
        destination = "/bin/${name}";
        executable = true;
        text = ''
          #!${pkgs.fish}/bin/fish
          ${builtins.readFile path}
        '';
      };
  };
  fish = {
    switch-monitor = builder.fish {
      name = "switch-monitor";
      path = ./scripts/fish/switch-monitor.fish;
    };
  };
in
{
  home.packages = [
    fish.switch-monitor
  ];
}
