{ pkgs, username, ... }:
{
  imports = [
    ./languages
    ./services
    ./themes
    ./programs
  ];
  users.users.${username} = {
    shell = pkgs.fish;
    description = "Henri Vandersleyen";
    isNormalUser = true;
    initialPassword = "temp123";
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
      fish
    ];
  };
}
