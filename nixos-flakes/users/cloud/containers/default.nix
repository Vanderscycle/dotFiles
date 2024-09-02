{ username, ... }:
{
  imports = [
    # ./portainer.nix
    ./transmission.nix
    ./home-automation.nix
    ./nextcloud.nix
    # ./bind9
    ./n8n.nix
  ];
}
