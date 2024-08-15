{ dir, ... }: (
  let
    cwd = builtins.baseNameOf dir;
    dirs = builtins.filter (f: f != "default.nix") (builtins.attrNames (builtins.readDir dir));
  in
  builtins.map (d: "${builtins.toPath "${dir}/${d}"}" + "/default.nix") dirs
)

