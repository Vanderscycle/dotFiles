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
    ./boot/systemd.nix
  ];

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
      rootless = {
        setSocketVariable = true;
        enable = true;
      };
    };
  };
}
