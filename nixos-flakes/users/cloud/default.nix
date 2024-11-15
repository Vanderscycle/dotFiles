{
  pkgs,
  username,
  hostname,
  ...
}:
{
  imports = [
    # ./secrets.nix
    ./services.nix
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
