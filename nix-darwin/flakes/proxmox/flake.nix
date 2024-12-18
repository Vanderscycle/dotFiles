{
  description = "A flake with Proxmox VE enabled";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    proxmox-nixos = {
      url = "github:SaumonNet/proxmox-nixos";
      # inputs.nixpkgs.follows = "nixpkgs"; # existing override
    };

    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      hosts,
      proxmox-nixos,
      ...
    }:
    {
      nixosConfigurations = {
        pve1 = nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            hostname = "pve1";
            username = "proxmox";
            system = "x86_64-linux";
            inherit inputs;
          } // inputs;
          modules = [

            proxmox-nixos.nixosModules.proxmox-ve
            (
              { pkgs, lib, ... }:
              {
                imports = [
                  ../../users/proxmox
                  ../../hosts
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
                  proxmox-nixos.overlays."x86_64-linux"
                ];

                services.openssh.enable = true;
              }
            )
          ];
        };
      };
    };
}
