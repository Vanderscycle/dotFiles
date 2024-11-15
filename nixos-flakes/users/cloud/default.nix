{
  pkgs,
  username,
  hostname,
  hosts,
  catppuccin,
  home-manager,
  ...
}:
{
  imports = [
    catppuccin.nixosModules.catppuccin
    home-manager.nixosModules.home-manager
    hosts.nixosModule
    {
      networking.stevenBlackHosts = {
        enable = true;
        blockFakenews = true;
        blockGambling = true;
      };
    }
    # local
    ./services.nix
    ../../hosts
    ../../modules
  ];

  users.users.${username} = {
    shell = pkgs.fish;
    description = "cloud user";
    isNormalUser = true;
    initialPassword = "temp123";
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  # Fixes for longhorn
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];
  virtualisation.docker.logDriver = "json-file";

  networking.firewall.enable = false;
}
