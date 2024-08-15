{ dir, ... }: builtins.map (d: "${builtins.toPath "${dir}/${d}"}/default.nix") (builtins.filter (f: f != "default.nix") (builtins.attrNames (builtins.readDir dir)))

