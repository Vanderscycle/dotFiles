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
    let
      system = "x86_64-darwin";
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
          # desired packages
          nativeBuildInputs = with pkgs; [
            kubernetes
          ];

          shellHook = ''
             ${pkgs.neofetch}/bin/neofetch
             echo -e "localhost shell activated" | ${pkgs.lolcat}/bin/lolcat
             echo "Available commands:"
             echo "  setup_cluster     - Create local Kubernetes cluster"
             echo "  generate_secrets  - Generate Kubernetes secrets"
             echo "  deploy_tilt        - Start Tilt development environment"
            echo "  all        - Run all previous commands"
          '';
        };
      };
    };
}
