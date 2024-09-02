{ username, ... }:
{
  imports = [
    ../../modules/containers/transmission.nix
    ../../modules/containers/home-automation.nix
    ../../modules/containers/nextcloud.nix
    ../../modules/containers/n8n.nix
    ../../modules/containers/bind9
  ];
}
