{ pkgs, username, ... }:
{
  imports = [
    ./languages.nix
    ./cron
    ./services
    ./programs
    ./containers
  ];
  users.users.${username} = {
    shell = pkgs.fish;
    description = "cloud";
    isNormalUser = true;
    initialPassword = "temp123";
    extraGroups = [
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ fish ];
  };
}
