{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    udisks
    fuse
    fuse3
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

  programs.fuse.userAllowOther = true;
  programs.fuse.mountMax = 1024;
}
