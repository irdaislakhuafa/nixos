{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    doas
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
