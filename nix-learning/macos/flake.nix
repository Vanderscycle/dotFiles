{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    {
      # Build darwin flake using:
      # nix run nix-darwin -- switch --flake .
      darwinConfigurations = {
        # this is the hostname
        # you can find yours using `hostname` in the cli
        macoss-iMac-Pro = nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          specialArgs = {
            username = "macos";
            inherit inputs;
          };
          modules = [
            ./configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                username = "macos";
                system = "x86_64-darwin";
                inherit inputs;
              };
              home-manager.users."macos" = {
                imports = [
                  ./home.nix
                ];

                # INFO: you can define the packages/config of home module here
                # but its cleaner to have them in ./home.nix
                # packages = with pkgs; [];
                # prograsm = {}
                # [...]
              };
            }
          ];
        };
      };
    };
}
