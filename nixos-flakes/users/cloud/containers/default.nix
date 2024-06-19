{ username, ... }:
{
  imports = [
    ./portainer.nix
    ./transmission.nix
    ./home-automation.nix
    ./bind9
  ];
  virtualisation = {
    oci-containers = {
      backend = "docker";
    };
  };
}
