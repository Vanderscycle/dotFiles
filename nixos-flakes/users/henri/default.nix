{
  pkgs,
  username,
  hostname,
  ...
}:
{
  imports = [
    ./languages.nix
    ./services.nix
    ./programs.nix
    ./containers.nix
    # ./secrets.nix
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
  };

}
