{ pkgs, username, ... }:
{
  imports = [
    ./languages
    ./services
    ./programs
  ];
  users.users.${username} = {
    shell = pkgs.fish;
    description = "Henri Vandersleyen";
    isNormalUser = true;
    initialPassword = "temp123";
    extraGroups = [
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ fish ];
  };
}
