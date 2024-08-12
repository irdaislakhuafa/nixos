{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    udisks
    fuse
    fuse3
    simple-mtpfs
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
  environment.shellAliases = (
    let
      getDevices = ''$(lsblk --json --output-all | jq -r '.blockdevices |.[]? | .path, (.children [ ]? | .path + "\t| " + .fstype + "\t| " + .size + " => " + .mountpoints [ ])' | fzf -m | cut -d '|' -f 1)'';
    in
    {
      mounts = ''
        devices=${getDevices};
        for device in $(echo $devices); do 
          udisksctl mount -b  $device & ; 
        done;
      '';
      unmounts = ''
        devices=${getDevices};
        for device in $(echo $devices); do 
          udisksctl unmount -b  $device & ; 
        done;
      '';
      diskoff = ''
        devices=${getDevices};
        for device in $(echo $devices); do 
          udisksctl poweroff -b  $device & ; 
        done;
      '';
    }
  );
}
