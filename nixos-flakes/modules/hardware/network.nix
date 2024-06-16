{ hostname, username, ... }:
{
  networking = {
    networkmanager.enable = true;
    hostName = "${hostname}"; # because we use nh os switch ensure the flakes +
  };

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
