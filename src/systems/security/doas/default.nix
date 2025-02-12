{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    doas
    # (runCommand "doas-sudo-symlink" {} '' mkdir -pv $out/bin/ && ln -sfv ${pkgs.doas}/bin/doas $out/bin/sudo'')
  ];
  
  security.doas.enable = true;
  security.doas.extraRules = [
    {
      groups = [
        "developer"
      ];
      noPass = false;
      keepEnv = true;
      persist = true;
    }
  ];
}
