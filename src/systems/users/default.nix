{ pkgs, config, ... }: rec {
  users.defaultUserShell = pkgs.zsh;
  users.groups = {
    developer = { };
    docker = { };
  };

  users.users = rec {
    i = {
      name = "i";
      group = "developer";
      description = "Irda Islakhu Afa";
      isNormalUser = true;
      extraGroups = [
        "docker"
        "developer"
        "wheel"
        "nixbld"
        "input"
      ];
      hashedPassword = "$6$V4KN67wwRfn8/ykm$.Ny0zPHGfRKHZNSreWEPUDGET3LQxPphR7ENwf9hm.9jhxiUAEKfRV1rzSg2EkcQ68EuPhHymhRzf8DLm.uMq0"; # hashed with `mkpassword -m sha-512`
    };
    root = {
      hashedPassword = "${i.hashedPassword}";
    };
  };

  services.getty.helpLine = "Welcome Developer, Lets Start Your Journey Today :)";
  services.getty.autologinUser = "${users.users.i.name}";
}

