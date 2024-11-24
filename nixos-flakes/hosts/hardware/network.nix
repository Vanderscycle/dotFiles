{
  hostname,
  username,
  hosts,
  ...
}:
{
  imports = [ hosts.nixosModule ];

  networking = {
    networkmanager.enable = true;
    hostName = "${hostname}"; # because we use nh os switch ensure the flakes +

    stevenBlackHosts = {
      enable = true;
      blockFakenews = true;
      blockGambling = true;
    };
  };

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
