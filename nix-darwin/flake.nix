{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      darwin,
      nix-homebrew,
      catppuccin,
      nixvim,
      ...
    }:
    let
      darwinMeta = {
        system = "aarch64-darwin";
        username = "henri.vandersleyen";
        hostname = "Henris-MacBook-Pro";
      };

      linuxMeta = {
        system = "x86_64-linux";
        username = "henri";
        hostname = "desktop";
        synology-nas = "192.168.1.246";
      };

      mediaMeta = {
        system = "x86_64-linux";
        username = "medialab";
        hostname = "medialab";
        synology-nas = "192.168.1.246";
      };
    in
    {
      darwinConfigurations = {
        #nix run nix-darwin -- switch --flake ./nix-darwin
        #nh darwin switch
        Henris-MacBook-Pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
            meta = darwinMeta;
          };
          modules = [
            {
              nixpkgs = {
                config = {
                  allowUnfree = true;
                  permittedInsecurePackages = [
                    "arc-browser-1.109.0-67185"
                  ];
                };
              };
            }
            ./users/henri.vandersleyen/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                meta = darwinMeta;
              };
              home-manager.users."henri.vandersleyen" = {
                imports = [
                  nixvim.homeModules.nixvim
                  catppuccin.homeModules.catppuccin
                  ./users/henri.vandersleyen/home.nix
                ];
              };
            }
          ];
        }; # Henris-MacBook-Pro
      };

      # sudo nixos-rebuild switch --flake ".#desktop" --impure
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            meta = linuxMeta;
          }
          // inputs;
          modules = [
            {
              nixpkgs = {
                hostPlatform = linuxMeta.system;
                config = {
                  allowUnfree = true;
                  permittedInsecurePackages = [
                    "electron-35.7.1"
                    "beekeeper-studio-5.3.4"
                  ];
                };
              };
            }
            ./users/henri/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                meta = linuxMeta;
              };
              home-manager.users."henri" = {
                imports = [
                  nixvim.homeModules.nixvim
                  catppuccin.homeModules.catppuccin
                  ./users/henri/home.nix
                ];
              };
            }
          ];
        }; # desktop
      };

      # sudo nixos-rebuild switch --flake ".#medialab" --impure
      nixosConfigurations = {
        medialab = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            meta = mediaMeta;
          }
          // inputs;
          modules = [
            # nixos
            ./users/medialab/configuration.nix
            {
              system.autoUpgrade = {
                enable = true;
                upgrade = false; # keep lockfile
                allowReboot = false;
                runGarbageCollection = true;
                flake = "github:Vanderscycle/dotFiles?dir=nix-darwin#medialab"; # doesn't work on private repos
                flags = [
                  "--impure"
                  "--refresh"
                ];
                dates = "daily";
                randomizedDelaySec = "45min";
              };
            }
            # home-manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                meta = mediaMeta;
              };
              home-manager.users."medialab" = {
                imports = [
                  nixvim.homeModules.nixvim
                  catppuccin.homeModules.catppuccin
                  ./users/medialab/home.nix
                ];
              };
            }
          ];
        }; # medialab
      };
    };
}
