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
  fileSystems."/mnt/rice/paperless" = {
    device = "//192.168.4.223/rice/paperless";
    fsType = "cifs";
    options = [
      "credentials=/root/smbcreds_fam"
      "dir_mode=0770"
      "file_mode=0770"
      "uid=paperless" # Set paperless as the owner
      "gid=smbaccess"
      "rw"
      "nofail" # Don't fail boot if mount fails
    ];
  };
  # create user for read only/
  # for nextcloud (and folder specific)
}
