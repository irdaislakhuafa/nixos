{ ... }: {
  environment.shellAliases = rec{
    noc = "nixos-container";
    dnoc = "doas ${noc}";
  };
}
