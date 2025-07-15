# ----------------------
# File system and drives
# ---------------------
{
  fileSystems."/mnt/backup" = {
    device = "/dev/nvme1n1p1";
    fsType = "auto";
    options = [
      "defaults"
      "noatime"
      "nofail"
      "compress=zstd"
    ];
  };
  fileSystems."/mnt/rice" = {
    device = "//192.168.4.223/rice";
    fsType = "cifs";
    options = [
      "credentials=/root/smbcreds_fam"
      "dir_mode=0770"
      "file_mode=0770"
      "uid=1000"
      "gid=1000"
      "defaults"
    ];
  };
}
