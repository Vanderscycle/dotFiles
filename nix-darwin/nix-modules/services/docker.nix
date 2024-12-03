{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
  ];

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        setSocketVariable = true;
        enable = true;
      };
    };
  };
}
