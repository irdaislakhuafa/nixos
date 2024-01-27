{pkgs, ...}:
{
  users.defaultUserShell = pkgs.zsh;
  users.groups = {
    developer = { };
  };

  users.users = {
    i = {
      group = "developer";
      description = "Irda Islakhu Afa";
      isNormalUser = true;
      extraGroups = [
        "docker"
      ];
    };
  };
}

