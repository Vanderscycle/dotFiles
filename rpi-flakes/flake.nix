{
  description = "My rpi k3s cluster configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ attrs:
    let
      supportedSystems = [ "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
   {
      nixosConfigurations = {
        master =
          let system = "aarch64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "guest"; # root
              hostname = "master";
              interface = "wlan0";
              inherit system;
            } // attrs;
            modules = [
              ./.
            ];
          }; #master
        worker =
          let system = "aarch64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "root";
              hostname = "worker";
              interface = "wlan0";
              inherit system;
            } // attrs;
            modules = [
              ./.
            ];
          }; #worker
      }; # nixosConfigurations

  };
}
