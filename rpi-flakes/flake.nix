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
      system = "aarch64-linux";
    in
   {
      nixosConfigurations = {
        master =
          nixpkgs.lib.nixosSystem {
            system = system;
            specialArgs = {
              hostname = "master";
              interface = "wlan0";
            } // attrs;
            modules = [
              ./.
              ./modules/master
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
