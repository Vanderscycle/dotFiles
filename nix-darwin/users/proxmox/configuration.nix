{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # services
    ../../nix-modules/services/networking.nix
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix

  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;

  users.users."proxmox" = {
    home = "/home/proxmox";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  # fonts.enableFontDir = true;
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    recursive
  ];

  environment.systemPackages = with pkgs; [
    openssl
    vim
    wget
    git
  ];

  environment.variables = {
  };

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=3600
  '';
}
