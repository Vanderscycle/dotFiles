  # ----------------------
  # File system and drives
  # ---------------------
{
  fileSystems."/mnt/backup" = {
    device = "/dev/nvme1n1p1";
    fsType = "auto";
    options = [ "defaults" "noatime" "nofail" "compress=zstd" ];
  };
 }
