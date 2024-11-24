{ dir, ... }:
let
  defaultFileName = "default.nix";
  listDir = builtins.readDir dir;
  listDirAttrNames = builtins.attrNames (listDir);
  filteredDir = builtins.filter (f: f != defaultFileName) (listDirAttrNames);
  mappedDir = builtins.map (d: "${builtins.toPath "${dir}/${d}"}/${defaultFileName}") (filteredDir);
in mappedDir

