# ============================================================================================
#
# ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
# ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
# ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
# ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
# ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
# ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝
#
# ============================================================================================
{
  description = "My personal computers nix configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    hosts.url = "github:StevenBlack/hosts";

    catppuccin.url = "github:catppuccin/nix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-scripts.url = "github:Vanderscycle/nixScripts";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-pre-commit = {
      url = "github:jmgilman/nix-pre-commit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      stable,
      hosts,
      nix-scripts,
      catppuccin,
      home-manager,
      nixvim,
      sops-nix,
      nix-pre-commit,
      ...
    }@inputs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
      nixosVersion = "24.11";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "henri";
            hostname = "desktop";
            palete-color = "mocha";
            inherit system;
            inherit inputs;
            inherit nixosVersion;
          } // inputs;
          modules = [
            # local
            ./.
            ./modules/gaming
            ./users/henri/programs/transmission
            ./users/henri/status-bars/waybar
            ./users/henri/window-managers/hyprland
            # hosts
            hosts.nixosModule
            {
              networking.stevenBlackHosts = {
                enable = true;
              };
            }
            # own scripts
            (
              { config, pkgs, ... }:
              {
                # Import the script as a package
                environment.systemPackages = with pkgs; [
                  nix-scripts.packages.${system}.output1
                  # nix-scripts.packages.${system}.output2
                  # nix-scripts.packages.${system}.output3
                  nix-scripts.packages.${system}.output4
                ];
              }
            )
            # theming
            catppuccin.nixosModules.catppuccin
            # home-manager
            home-manager.nixosModules.home-manager
          ];
        }; # desktop

        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "henri";
            hostname = "laptop";
            palete-color = "mocha";
            inherit system;
            inherit inputs;
            inherit nixosVersion;
          } // inputs;
          modules = [
            # local
            ./.
            ./users/henri/desktop-environment/xfce
            ./users/henri/window-managers/lightdm
            # hosts
            hosts.nixosModule
            {
              networking.stevenBlackHosts = {
                enable = true;
              };
            }
            # theming
            catppuccin.nixosModules.catppuccin
            # home-manager
            home-manager.nixosModules.home-manager
          ];
        }; # laptop

        cloud = nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "cloud";
            hostname = "cloud";
            palete-color = "mocha";
            inherit system;
            inherit inputs;
            inherit nixosVersion;
          } // inputs;
          modules = [
            # local
            ./.
            ./users/henri/desktop-environment/xfce
            ./users/henri/window-managers/lightdm
            # hosts
            hosts.nixosModule
            {
              networking.stevenBlackHosts = {
                enable = true;
              };
            }
            # theming
            catppuccin.nixosModules.catppuccin
            # home-manager
            home-manager.nixosModules.home-manager
          ];
        }; # cloud

        wife = nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "jean";
            hostname = "wife";
            palete-color = "mocha";
            inherit system;
            inherit inputs;
            inherit nixosVersion;
          } // inputs;
          modules = [
            # local
            ./.
            ./modules/gaming
            ./users/jean/window-managers/gnome
            # hosts
            hosts.nixosModule
            {
              networking.stevenBlackHosts = {
                enable = true;
                blockFakenews = true;
                blockGambling = true;
              };
            }
            # theming
            catppuccin.nixosModules.catppuccin
            # home-manager
            home-manager.nixosModules.home-manager
          ];
        }; # wife
      }; # nixosConfigurations

      templates.default = {
        path = ./.;
        description = "The default template for common nixflakes.";
      }; # templates

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
