{ pkgs, username, ... }:
{
  imports = [
    ./fish
    #./languages
    #./services
    #./themes
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

