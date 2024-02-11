{
  description = "My rpi k3s cluster configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    colmena.url = "github:zhaofengli/colmena";
    hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, hardware, colmena, nixpkgs, ... } @ attrs:
    let
      supportedSystems = [ "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
      system = "aarch64-linux";

      commonConfiguration = { pkgs, ... }: {
        imports = [
          hardware.nixosModules.raspberry-pi-4
        ];
      };
    in
   {
      nixosConfigurations = {
        master =
          nixpkgs.lib.nixosSystem {
            system = system;
            specialArgs = {
              hostname = "master";
              interface = "wlan0";
              commonConfig = commonConfiguration;
            } // attrs;
            modules = [
              ./.
              #./modules/master
              ({ config, pkgs, ... }: {
                imports = [ attrs.commonConfig ];
              })
            ];
          }; #master
        worker =
          nixpkgs.lib.nixosSystem {
            system = system;
            specialArgs = {
              hostname = "worker";
              interface = "wlan0";
            } // attrs;
            modules = [
              ./.
              # ./modules/worker
            ];
          }; #worker
      }; # nixosConfigurations

  };
}
