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
    ./sops.nix
    ./k3s.nix
    ./disko.nix

    ../../hosts/hardware
    ../../hosts/internationalisation
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

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCpHZBybBTCsCyW6/Q4OZ07SvUpRUvclc10u25j0B+Q hvandersleyen@gmail.com"
  ];
  # Fixes for longhorn
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];
  virtualisation.docker.logDriver = "json-file";

  networking.firewall.enable = false;
}
