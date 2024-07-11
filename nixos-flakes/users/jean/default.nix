{ pkgs, username, ... }:
{
  imports = [
    ./programs
    ./services
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
    packages = with pkgs; [ fish ];
  };
}
