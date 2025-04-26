{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
      catppuccin,
      nixvim,
      sops-nix,
      firefox-addons,
      rose-pine-hyprcursor,
      hosts,
      ...
    }:
    let
    in
    {
      darwinConfigurations = {
        #nix run nix-darwin -- switch --flake ./nix-darwin
        Henris-MacBook-Pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            username = "henri.vandersleyen";
            inherit inputs;
          };
          modules = [
            ./users/henri.vandersleyen/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                username = "henri.vandersleyen";
                system = "aarch64-darwin";
                inherit inputs;
              };
              home-manager.users."henri.vandersleyen" = {
                imports = [

                  nixvim.homeManagerModules.nixvim
                  catppuccin.homeModules.catppuccin
                  ./users/henri.vandersleyen/home.nix
                ];
              };
            }
          ];
        }; # Henris-MacBook-Pro
      };

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            hostname = "desktop";
            username = "henri";
            system = "x86_64-linux";
            inherit inputs;
          } // inputs;
          modules = [
            ./users/henri/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                username = "henri";
                hostname = "desktop";
                system = "x86_64-linux";
              };
              home-manager.users."henri" = {
                imports = [
                  nixvim.homeManagerModules.nixvim
                  catppuccin.homeManagerModules.catppuccin
                  ./users/henri/home.nix
                ];
              };
            }
          ];
        }; # desktop
      };
    };
}
