{ username, pkgs, ... }:
{
  users.users.${username} = {
    extraGroups = [ "docker" ];
  };
  environment.systemPackages = with pkgs; [
    docker
  ];
  virtualisation = {
    docker = {
      enable = true;
      # storageDriver = "btrfs";
      rootless = {
        setSocketVariable = true;
        enable = true;
      };
    };
  };

}
