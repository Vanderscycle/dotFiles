{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ attrs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      nixosConfigurations = {

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
              # ./modules/virt
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
