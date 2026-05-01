{ ... }:
{
  den.aspects.chagatai = {
    nixos = {
      swapDevices = [
      ];
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/97736025-4562-4aa6-bf5e-b79be12fbcf8";
          fsType = "ext4";
        };
      };
    };
  };
}
