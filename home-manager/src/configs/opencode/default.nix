{ pkgs, lib, ... }:
let
  isEnable = false;
  fetchedPinnedPkgs = builtins.fetchTarball rec {
    url = "https://github.com/NixOS/nixpkgs/archive/da289b19d0cbe59c3d3a060bcc990dc955124c64.tar.gz";
    sha256 = "0yw56b5xvf4vjbn6ss5g7ibnrsadmy10qhggw5h0ncx2klv7827m";
  };
  pinnedPkgs = import fetchedPinnedPkgs {
    inherit (pkgs) system config;
  };
in
lib.mkIf (isEnable) {
  home.packages = [ pinnedPkgs.opencode ];
  home.file.".config/opencode/opencode.json" = {
    enable = true;
    text = builtins.readFile ./config/opencode.json;
  };
}
