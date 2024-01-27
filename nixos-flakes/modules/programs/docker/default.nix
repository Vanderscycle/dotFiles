{ username, pkgs, ... }:
{
  users.users.${username} = {
    extraGroups = [ "docker" ];
  };
  environment.systemPackages = with pkgs; [
    docker
  ];
  virtualisation = {
    oci-containers = {
      backend = "docker";
      containers = {
      };
    };
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
