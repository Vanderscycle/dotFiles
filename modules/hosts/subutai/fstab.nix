{ ... }:
{
  den.aspects.subutai = {
    nixos = {
      swapDevices = [
        { device = "/dev/disk/by-uuid/2815b75c-bc2a-4f8f-97ec-0506381c38fe"; }
      ];
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/5e0d29d0-3c82-410f-bf70-125a65e65dda";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/0431-4073";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };
    };
  };
}
