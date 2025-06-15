{
  description = "Monolith homelab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/nlewo/comin
    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      sops-nix,
      comin,
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
          ];
        };
      };
    };
}
