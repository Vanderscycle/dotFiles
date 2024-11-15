{ pkgs, username, ... }:
{
  imports = [
    ./programs.nix
    ./services.nix
  ];

  users.users.${username} = {
    shell = pkgs.fish;
    description = "Jean Sun";
    isNormalUser = true;
    initialPassword = "temp123";
    extraGroups = [
      "wheel"
      "docker"
    ];
  };
}
