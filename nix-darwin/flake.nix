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
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      darwin,
      catppuccin,
      nixvim,
      sops-nix,
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
            inherit inputs;
          };
          modules = [
            ./users/henri.vandersleyen/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
              home-manager.users."henri.vandersleyen" = {
                imports = [

                  nixvim.homeManagerModules.nixvim
                  catppuccin.homeManagerModules.catppuccin
                  ./users/henri.vandersleyen/home.nix
                ];
              };
            }
          ];
        };
      };

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            hostname = "desktop";
            username = "henri";
            inherit inputs;
          } // inputs;
          modules = [
            ./users/henri/configuration.nix
            ./users/henri/sops.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
              home-manager.users."henri" = {
                imports = [
                  nixvim.homeManagerModules.nixvim
                  catppuccin.homeManagerModules.catppuccin
                  ./users/henri/home.nix
                ];
              };
            }
            # local
            # ./.
            # ./modules/gaming
            # ./modules/programs/transmission
            # ./modules/status-bars/waybar
            # ./modules/window-managers/hyprland
            # # own scripts
          ];
        }; # desktop
      };
    };
}
