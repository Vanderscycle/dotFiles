{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    catppuccin.url = "github:catppuccin/nix";

    # disko = {
    # url = "github:nix-community/disko";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      spicetify-nix,
      hosts,
      nixpkgs,
      disko,
      nixos-facter-modules,
      sops-nix,
      nixvim,
      catppuccin,
      home-manager,
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
              ./configuration.nix
              ./sops.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  username = "proxmox";
                  hostname = name;
                  system = "x86_64-linux";
                };
                home-manager.users."proxmox" = {
                  imports = [
                    nixvim.homeManagerModules.nixvim
                    catppuccin.homeManagerModules.catppuccin
                    ./home.nix
                  ];
                };
              }
            ];
          };
        }) nodes
      );
    };
}
