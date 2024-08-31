{ hostname, ... }:
{
  imports = [
    ./nix
    ./security
    ./terminal
    ./docker.nix
  ] ++ (if hostname == "cloud" then [ ./boot/systemd/cloud.nix ] else [ ./boot/systemd ]);
}
