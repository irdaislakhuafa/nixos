{pkgs, ...}:
{
  users.groups = {
    developer = { };
  };

  users.users = {
    i = {
      group = "developer";
      description = "Irda Islakhu Afa";
      isNormalUser = true;
    };
  };
}

