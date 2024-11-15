{
  username,
  hostname,
  pkgs,
  ...
}:
{
  imports = [
    ./nix
    ./security
    ./fonts.nix
  ] ++ (if hostname == "cloud" then [ ./boot/grub-cloud.nix ] else [ ./boot/systemd.nix ]);

  # shell
  programs.fish = {
    enable = true;
  };

  # docker/virt
  environment.systemPackages = with pkgs; [
    docker
  ];

  virtualisation = {
    docker = {
      enable = true;
      # storageDriver = "btrfs";
      rootless = {
        setSocketVariable = true;
        enable = true;
      };
    };
  };
}
