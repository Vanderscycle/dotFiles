{
  description = "A very basic flake";

  inputs = {
    hosts.url = github:StevenBlack/hosts;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hosts, ... } @ attrs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      nixosConfigurations = {

        desktop =
          let system = "x86_64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "henri";
              hostname = "desktop";
              inherit system;
            } // attrs;
            modules = [
              ./.
              ./modules/programs/gaming
              ./modules/programs/multimedia
              ./modules/cloud
              hosts.nixosModule {
                networking.stevenBlackHosts.enable = true;
              }
            ];
          }; #desktop
        laptop =
          let system = "x86_64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "henri";
              hostname = "laptop";
              inherit system;
            } // attrs;
            modules = [
              ./.
              ./modules/programs/multimedia
              ./modules/desktop-environment/xfce
              ./modules/cloud
              hosts.nixosModule {
                networking.stevenBlackHosts.enable = true;
              }
            ];
          }; #laptop
      }; # nixosConfigurations

      templates.default = {
        path = ./.;
        description = "The default template for common nixflakes.";
      }; #templates

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
