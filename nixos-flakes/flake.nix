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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
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
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # check usage!
    nix-pre-commit = {
      url = "github:jmgilman/nix-pre-commit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # also flake-utils?
    # https://github.com/numtide/flake-utils
  };

  outputs =
    {
      self,
      nixpkgs,
      stable,
      hosts,
      nix-scripts,
      spicetify-nix,
      catppuccin,
      home-manager,
      nixvim,
      sops-nix,
      nix-darwin,
      # nix-pre-commit,
      ...
    }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

      nixosVersion = "24.11";
    in
    {

      darwinConfigurations = {
        macM2 = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = import nixpkgs { system = "aarch64-darwin"; };
          specialArgs = {
            username = "henri.vandersleyen";
            inherit inputs;
            inherit nixosVersion;
            inherit catppuccin;
          };
          modules = [
            ./users
            home-manager.darwinModules.home-manager
            {
              home-manager.users."henri.vandersleyen".home.stateVersion = "24.11";
              home-manager.users."henri.vandersleyen".home.homeDirectory = "/Users/henri.vandersleyen";
            }
          ];
        }; # laptop
      };

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "henri";
            hostname = "desktop";
            system = "x86_64-linux";
            inherit inputs;
            inherit nixosVersion;
          } // inputs;
          modules = [
            # local
            ./.
            ./modules/gaming
            ./modules/programs/transmission
            ./modules/status-bars/waybar
            ./modules/window-managers/hyprland
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
          ];
        }; # desktop

        wife = nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "jean";
            hostname = "wife";
            system = "x86_64-linux";
            inherit inputs;
            inherit nixosVersion;
          } // inputs;
          modules = [
            # local
            ./.
            ./modules/gaming
            ./modules/desktop-environment/xfce
            ./modules/window-managers/lightdm
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
