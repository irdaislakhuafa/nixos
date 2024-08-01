{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    udisks
  ];
  services.udisks2.enable = true;
  services.udisks2.mountOnMedia = false;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.startsWith("org.freedesktop.udisks2.") && subject.isInGroup("${config.users.users.i.group}")) {
        return polkit.Result.YES;
      }
    })
  '';
}
