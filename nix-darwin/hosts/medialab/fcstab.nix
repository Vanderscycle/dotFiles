{ meta, ... }:
# ----------------------
# File system and drives
# ---------------------
{
  fileSystems."/mnt/synology" = {
    device = "//${meta.synology-nas}/media";
    fsType = "cifs";
    options = [
      "credentials=/root/synology"
      "dir_mode=0770"
      "file_mode=0770"
      "uid=1000"
      "gid=1000"
      "defaults"
    ];
  };
  # fileSystems."/mnt/rice" = {
  #   device = "//${meta.synology-nas}/rice";
  #   fsType = "cifs";
  #   options = [
  #     "credentials=/root/smbcreds_fam"
  #     "dir_mode=0770"
  #     "file_mode=0770"
  #     "uid=1000"
  #     "gid=1000"
  #     "defaults"
  #   ];
  # };
}
