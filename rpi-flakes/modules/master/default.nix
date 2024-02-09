# { hostname, pkgs, ... }:
# {
#   environment.etc."boot/cmdline.txt".text = ''
#     console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait cgroup_memory=1 cgroup_enable=memory ip=10.7.1.60::10.7.1.3:255.255.255.0:${hostname}:eth0:off
#   '';
# }
{
  imports = [
    ./cmdline.nix
    ./iptables.nix
  ]
}
