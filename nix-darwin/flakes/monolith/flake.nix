{
  description = "Monolith homelab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    quadlet-nix = {
      url = "github:SEIAROTg/quadlet-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      quadlet-nix,
      nixpkgs,
      sops-nix,
      ...
    }:
    {
      nixosConfigurations = {
        monolith = nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            meta = {
              hostname = "monolith";
              username = "monolith";
            };
            system = "x86_64-linux";
            inherit inputs;
          } // inputs;
          modules = [
            ./configuration.nix
            quadlet-nix.nixosModules.quadlet
          ];
        };
      };
    };
}
