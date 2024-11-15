{
  pkgs,
  username,
  hostname,
  ...
}:
{
  imports = [
    # ./secrets.nix
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
  };

}
