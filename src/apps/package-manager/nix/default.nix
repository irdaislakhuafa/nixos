{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-search-cli
    direnv
    nix-direnv
    nixpkgs-fmt
    nix-inspect
    devbox
  ];
  environment.shellAliases =
    let
      log = " --log-format bar ";
      fast = " --fast";
    in
    {
      nos-switch = "nixos-rebuild switch ${fast} ${log}";
      nix-shell = "nix-shell ${log}";
      nix-env = "nix-env ${log}";
    };
  nix.settings = {
    trusted-users = [
      "@developer"
      "root"
    ];
    extra-experimental-features = [
      "flakes"
      "nix-command"
    ];
  };
}
