{
  pkgs,
  config,
  lib,
  ...
}:
let
  aliases = (
    let
      getDevices = ''$(lsblk --json --output-all | jq -r '.blockdevices |.[]? | .path, (.children [ ]? | .path + "\t| " + .fstype + "\t| " + .size + " => " + .mountpoints [ ])' | fzf -m | cut -d '|' -f 1)'';
      logLocation = ''/dev/null'';
    in
    lib.mapAttrsToList (name: value: (pkgs.writeShellScriptBin name value)) ({
      mounts = ''
        devices=${getDevices};
        for device in $(echo $devices); do
          (udisksctl mount -b  $device 2> ${logLocation} > ${logLocation} && notify-send "Success mounting $device" || notify-send --urgency="critical" --expire-time=${toString (1000 * 15)} "Failed mounting $device") &! ;
        done;
      '';
      unmounts = ''
        devices=${getDevices};
        for device in $(echo $devices); do
          (udisksctl unmount -b  $device 2> ${logLocation} > ${logLocation} && notify-send "Success unmounting $device" || notify-send --urgency="critical" --expire-time=${toString (1000 * 15)} "Failed mounting $device") &! ;
        done;
      '';
      diskoff = ''
        devices=${getDevices};
        for device in $(echo $devices); do
          (udisksctl poweroff -b  $device 2> ${logLocation} > ${logLocation} && notify-send "Success poweroff $device" || notify-send --urgency="critical" --expire-time=${toString (1000 * 15)} "Failed mounting $device") &! ;
        done;
      '';
    })
  );
in
{
  environment.systemPackages = with pkgs; [
    udisks
    fuse
    fuse3
    simple-mtpfs
  ]++aliases;
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
