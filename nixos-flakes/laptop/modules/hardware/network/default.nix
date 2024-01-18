{ hostname, username, ... }:
{
  networking = {
    networkmanager.enable = true;
    hostName = "${hostname}";
    extraHosts =
      let
        hostsPath = https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts;
        hostsFile = builtins.fetchurl hostsPath;
      in
      builtins.readFile "${hostsFile}";
  };

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };

}
