{
  pkgs,
  username,
  hostname,
  ...
}:
{
  imports = [
    ./languages
    ./services
    ./programs
    ./containers
  ] ++ (if hostname == "laptop" then [ ./laptop-only ] else [ ]);

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
