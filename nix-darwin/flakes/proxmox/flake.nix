{
  description = "A flake with Proxmox VE enabled";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    proxmox-nixos = {
      url = "github:SaumonNet/proxmox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      hosts,
      proxmox-nixos,
      ...
    }:
    {
      nixosConfigurations = {
        pve1 = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [

            proxmox-nixos.nixosModules.proxmox-ve
            (
              { pkgs, lib, ... }:
              {
                imports = [
                  ./hardware-configuration.nix
                  ../../users/proxmox
                ];

                services.proxmox-ve = {
                  enable = true;
                  ipAddress = "192.168.1.168";
                };

                users.users.root = {
                  password = "mypassword";
                  initialPassword = null;
                  hashedPassword = null;
                  hashedPasswordFile = null;
                };

                nixpkgs.overlays = [
                  proxmox-nixos.overlays.${system}
                ];

                boot.loader = {
                  systemd-boot.enable = true;
                  efi.canTouchEfiVariables = true;
                };
                services.openssh.enable = true;
              }
            )
          ];
        };
      };
    };
}
