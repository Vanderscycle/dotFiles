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
    hosts.url = "github:StevenBlack/hosts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      hosts,
      nix-scripts,
      catppuccin,
      home-manager,
      nixvim,
      sops-nix,
      ...
    }@inputs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      nixosConfigurations = {
        desktop =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "henri";
              hostname = "desktop";
              palete-color = "mocha";
              inherit system;
              inherit inputs;
            } // inputs;
            modules = [
              # local
              ./.
              ./modules/programs/gaming
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
                    nix-scripts.packages.${system}.output2
                    nix-scripts.packages.${system}.output3
                  ];
                }
              )
              # theming
              catppuccin.nixosModules.catppuccin
              # home-manager
              home-manager.nixosModules.home-manager
            ];
          }; # desktop

        laptop =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "henri";
              hostname = "laptop";
              palete-color = "mocha";
              inherit system;
              inherit inputs;
            } // inputs;
            modules = [
              # local
              ./.
              ./modules/desktop-environment/xfce
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

        cloud =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "cloud";
              hostname = "cloud";
              palete-color = "mocha";
              inherit system;
              inherit inputs;
            } // inputs;
            modules = [
              ./.
              ./modules/desktop-environment/xfce
              ./users/cloud/window-managers/lightdm
              hosts.nixosModule
              { networking.stevenBlackHosts.enable = true; }
              catppuccin.nixosModules.catppuccin
              home-manager.nixosModules.home-manager
            ];
          }; # cloud
      }; # nixosConfigurations

      templates.default = {
        path = ./.;
        description = "The default template for common nixflakes.";
      }; # templates

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
