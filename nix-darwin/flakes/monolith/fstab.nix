{ meta, ... }:

# ----------------------
# File system and drives
# ---------------------
{
  fileSystems."/mnt/rice" = {
    device = "//192.168.4.223/rice";
    fsType = "cifs";
    options = [
      "credentials=/root/smbcreds_fam"
      "dir_mode=0770"
      "file_mode=0770"
      "uid=0" # root
      "gid=smbaccess"
      "defaults"
    ];
  };
  fileSystems."/mnt/paperless" = {
    device = "//192.168.4.223/rice/paperless";
    fsType = "cifs";
    options = [
      "credentials=/home/${meta.username}/smbcreds_fam_user"
      "dir_mode=0770"
      "file_mode=0770"
      "uid=paperless"
      "gid=paperless"
      "defaults"
    ];
  };
  fileSystems."/mnt/transmission" = {
    device = "//192.168.4.223/rice/transmission";
    fsType = "cifs";
    options = [
      "credentials=/home/${meta.username}/smbcreds_fam_user"
      "dir_mode=0770"
      "file_mode=0770"
      "uid=transmission"
      "gid=transmission"
      "defaults"
    ];
  };
  # create user for read only/
  # for nextcloud (and folder specific)
}
