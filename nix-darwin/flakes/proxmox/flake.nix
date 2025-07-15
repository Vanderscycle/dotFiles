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
                  ../../users/proxmox/home.nix
                ];
              };
            }
            proxmox-nixos.nixosModules.proxmox-ve
            (
              { pkgs, lib, ... }:
              let
                minimalIso = pkgs.fetchurl {
                  url = "https://releases.nixos.org/nixos/24.05/nixos-24.05.7139.bcba2fbf6963/nixos-minimal-24.05.7139.bcba2fbf6963-x86_64-linux.iso";
                  hash = "sha256-plre/mIHdIgU4xWU+9xErP+L4i460ZbcKq8iy2n4HT8=";
                };
              in
              {
                imports = [
                  ../../users/proxmox/configuration.nix
                  ../../hosts
                ];

                services.proxmox-ve = {
                  enable = true;
                  ipAddress = "192.168.1.168";
                  ceph = {
                    enable = true;
                    mgr.enable = true;
                    mon.enable = true;
                    osd = {
                      enable = true;
                      daemons = [ "1" ];
                    };
                  };
                  # vms
                  vms = {
                    node1 = {
                      vmid = 100;
                      memory = 4096;
                      cores = 4;
                      sockets = 2;
                      kvm = true
                      scsi = [ { file = "local:16"; } ];
                      cdrom = "local:iso/minimal.iso";
                    };
                    node2 = {
                      vmid = 101;
                      memory = 4096;
                      cores = 4;
                      sockets = 2;
                      kvm = true
                      scsi = [ { file = "local:32"; } ];
                      cdrom = "local:iso/minimal.iso";
                    };
                  };
                };

                networking.interfaces.enp10s0 = {
                  ipv4.addresses = [
                    {
                      address = "191.168.1.168";
                      prefixLength = 24;
                    }
                  ];
                };

                users.users.root = {
                  password = "mypassword";
                  initialPassword = null;
                  hashedPassword = null;
                  hashedPasswordFile = null;
                };

                users.users.proxmox= {
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
