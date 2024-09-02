{
  pkgs,
  username,
  hostname,
  ...
}:
{
  imports = [
    ./languages.nix
    ./services
    ./programs
    ./containers
  ] ++ (if hostname == "laptop" then [ ./laptop-only ] else [ ./security ]);

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
