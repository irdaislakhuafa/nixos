{ pkgs, ... }:
let
  # search nix packages
  nixsrch = (
    pkgs.writeShellScriptBin "nixsrch" (
      let
        withKeys = true;
        jqKeyArgs = if (withKeys) then (''.key + "#"'') else (''""'');
        jqPackageVersionSep = "@";
        jqLayout = ''.[] | ${jqKeyArgs} + .value.pname + "${jqPackageVersionSep}" + .value.version + ": " + .value.description'';
      in
      ''
        args="$@";
        results_json=$(nix search $args --json);
        if [ "$results_json" = "" ]; then
          exit;
        fi
        
        results_entries="$(echo $results_json | jq 'to_entries')";
        selected_pkg=$(echo -n $results_entries | jq '${jqLayout}' | sed -e 's@"@@g' | fzf | cut -d '${jqPackageVersionSep}' -f 1);
        echo $selected_pkg;
      ''
    )
  );
in
{
  environment.systemPackages = with pkgs; [
    nix-search-cli
    nixpkgs-fmt
    nixsrch
  ];
  environment.shellAliases = (
    let
      log = " --log-format bar --quiet";
      fast = " --fast";
    in
    {
      nos-switch = "nixos-rebuild switch ${fast} ${log}";
      nix-shell = "nix-shell ${log}";
      nix-env = "nix-env ${log}";
      nix = "nix ${log}";
    }
  );
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
