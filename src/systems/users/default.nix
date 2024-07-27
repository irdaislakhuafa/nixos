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
      ];
      hashedPassword = "$6$0fd5Oge9N2Dl4VQ9$P1a8IpGwqT6DtIooIYUZixCdssDmcndrrpXAGe0PuoufSAu9kZ6zQgCk8p.Pp8iS15VNXpTHiLnuDi5vNsxn8.";
    };
    root = {
      hashedPassword = "${i.hashedPassword}";
    };
  };

  services.getty.helpLine = "Welcome Developer, Lets Start Your Journey Today :)";
  services.getty.autologinUser = "${users.users.i.name}";
}

