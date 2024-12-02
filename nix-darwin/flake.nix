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
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      darwin,
      catppuccin,
      spicetify-nix,
      nixvim,
      ...
    }:
    let
      nixosVersion = "24.11";
    in
    {
      darwinConfigurations = {
        #nix run nix-darwin -- switch --flake ./nix-darwin 
        Henris-MacBook-Pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
            inherit nixosVersion;
          };
          modules = [
            ./configuration.nix
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
                  ./home.nix
                ];
              };
            }
          ];
        };
      };
    };
}
