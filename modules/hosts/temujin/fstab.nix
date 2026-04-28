{ ... }:
{
  den.aspects.temujin = {
    nixos = {
      swapDevices = [
        {
          device = "/var/lib/swapfile";
          size = 16 * 1024; # 16 GiB
        }
      ];
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/d94e1efb-8e9d-40f3-9479-f3f94ec0c774";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/ED33-5B04";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
        "/mnt/backup" = {
          device = "/dev/nvme1n1p1";
          fsType = "auto";
          options = [
            "defaults"
            "noatime"
            "nofail"
            # "compress=zstd"
          ];
        };
      };
    };
  };
  # local
  # nas
  # fileSystems."/mnt/synology" = {
  #   device = "//${meta.synology-nas}/media";
  #   fsType = "cifs";
  #   options = [
  #     "credentials=/root/synology"
  #     "dir_mode=0770"
  #     "file_mode=0770"
  #     "uid=1000"
  #     "gid=1000"
  #     "defaults"
  #   ];
  # };
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
