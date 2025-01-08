{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # disko = {
    # url = "github:nix-community/disko";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      disko,
      nixos-facter-modules,
      sops-nix,
      ...
    }@inputs:
    let
      # sudo nixos-rebuild switch --flake ".#node-0"
      nodes = [
        "node-0"
        "node-1"
        "node-2"
        "node-3"
      ];
    in
    {
      # Use this for all other targets
      # nixos-anywhere --flake .#generic-nixos-facter --generate-hardware-config nixos-generate-config ./hardware-configuration.nix <hostname>
      # nixosConfigurations.generic = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     disko.nixosModules.disko
      #     ./configuration.nix
      #     ./disko-config.nix
      #     ./hardware-configuration.nix
      #   ];
      # };
      nixosConfigurations = builtins.listToAttrs (
        map (name: {
          name = name;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "proxmox";
              inherit inputs;
              meta = {
                hostname = name;
              };
            };
            system = "x86_64-linux";
            modules = [
              # Modules
              # disko.nixosModules.disko
              # ./disko-config.nix
              ./hardware-configuration.nix
              ./configuration.nix
              ./sops.nix
            ];
          };
        }) nodes
      );
    };
}
