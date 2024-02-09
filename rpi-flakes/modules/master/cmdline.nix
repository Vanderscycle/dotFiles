{ hostname, lib, pkgs, ... }:

{
  networking = {
    hostName = hostname; # Set the system's host name
    useDHCP = false; # Disable DHCP
    interfaces.eth0 = {
      useDHCP = false;
      ipv4 = {
        addresses = [
          { address = "10.7.1.60"; }
        ];
        routes = [
          { address = "default"; via = "10.7.1.3"; }
        ];
      };
    };
  };

  boot.kernelParams = [
    "console=serial0,115200"
    "console=tty1"
    "root=/dev/mmcblk0p2"
    "rootfstype=ext4"
    "elevator=deadline"
    "fsck.repair=yes"
    "rootwait"
    "cgroup_memory=1"
    "cgroup_enable=memory"
  ];

  # Ensure the system is configured for the required cgroups
  boot.kernel.sysctl = {
    "kernel.cgroup.memory" = 1;
    "kernel.cgroup.enable" = "memory";
  };

  environment.etc."boot/cmdline.txt".text = lib.mkForce "";
}
