{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # my own packages
    nix-scripts = {
      url = "github:vancycles-knak/nixScripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-scripts,
      home-manager,
    }:
    let
      # system = "x86_64-darwin";
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
    in
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

      devShells.${system} = {
        # nix develop .#default
        default = (
          import ./shell.nix {
            inherit pkgs;
            inherit inputs;
          }
        );

        # nix develop .#anotherEnv
        anotherEnv = pkgs.mkShell {
          name = "localhost-shell";
          # desired packages, notice how lolcat/neofetch isn't present
          nativeBuildInputs = with pkgs; [
            sl
            nix-scripts.packages.${system}.output2
          ];

          shellHook = ''
            ${pkgs.neofetch}/bin/neofetch
            echo -e "localhost shell activated" | ${pkgs.lolcat}/bin/lolcat
            echo "Available commands:"
            echo "sl        - choo choo"
            echo "myscript2 - a small bash script packaged with nix"
          '';
        };
      };
    };
}
