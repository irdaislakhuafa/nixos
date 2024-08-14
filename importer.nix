{ cwd, ... }:
let
  dirs = builtins.filter (f: f != "default.nix") (builtins.attrNames (builtins.readDir cwd));
in
builtins.map (dir: "${builtins.toPath ./${dir}}" + "/default.nix") dirs
