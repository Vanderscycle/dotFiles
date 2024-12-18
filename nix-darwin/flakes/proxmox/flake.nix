{
  description = "A flake with Proxmox VE enabled";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";

    proxmox-nixos = {
      url = "github:SaumonNet/proxmox-nixos";
      # inputs.nixpkgs.follows = "nixpkgs"; # existing override
    };

    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      hosts,
      proxmox-nixos,
      home-manager,
      catppuccin,
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
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                username = "proxmox";
                hostname = "pve1";
                system = "x86_64-linux";
              };
              home-manager.users."proxmox" = {
                imports = [
                  catppuccin.homeManagerModules.catppuccin
                  ./users/henri/home.nix
                ];
              };
            }
            proxmox-nixos.nixosModules.proxmox-ve
            (
              { pkgs, lib, ... }:
              {
                imports = [
                  ../../users/proxmox/configuration.nix
                  ../../hosts
                ];

                services.proxmox-ve = {
                  enable = true;
                  ipAddress = "192.168.1.168";
                };

                networking.interfaces.enp10s0 = {
                  ipv4.addresses = [
                    {
                      address = "191.168.1.168";
                      netmask = "255.255.255.0";
                    }
                  ];
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
