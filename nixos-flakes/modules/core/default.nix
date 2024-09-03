{ hostname, ... }:
{
  imports = [
    ./nix
    ./security
    ./fonts.nix
    ./shell.nix
    ./docker.nix
  ] ++ (if hostname == "cloud" then [ ./boot/grub-cloud.nix ] else [ ./boot/systemd.nix ]);
}
