{ config, pkgs, lib, ... }: {
  imports = (
    let
      dirs = builtins.filter (f: f != "default.nix") (builtins.attrNames (builtins.readDir ./.));
    in
    builtins.map (dir: "${builtins.toPath ./${dir}}" + "/default.nix") dirs
  );
}
