{
  imports = [
    ./ssh.nix
    ./gnupg.nix
    ./polkit.nix
    ./firewall.nix
  ];
  security = {
    rtkit.enable = true;
    # https://github.com/NixOS/nixpkgs/issues/40157#issuecomment-387269306
    sudo.extraConfig = ''
      Defaults        timestamp_timeout=3600
    '';
  };
}
