{ hostname, lib, pkgs, ... }:

{
  networking = {
    hostName = hostname; # Set the system's host name
    useDHCP = false; # Disable DHCP for all interfaces
    interfaces.eth0 = {
      useDHCP = false; # Specifically disable DHCP on eth0
      ipv4 = {
        addresses = [
          { address = "10.7.1.60"; prefixLength = 24; } # Include prefixLength for the IP address
        ];
        routes = [ # Correct location for route configuration
          { address = "default"; via = "10.7.1.3"; prefixLength = 24;} # Define the default gateway
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

  boot.kernel.sysctl = {
    "kernel.cgroup.memory" = 1;
    "kernel.cgroup.enable" = "memory";
  };

  environment.etc."boot/cmdline.txt".text = lib.mkForce "";
}
