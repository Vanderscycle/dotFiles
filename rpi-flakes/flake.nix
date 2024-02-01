{
  description = "My rpi k3s cluster configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ attrs:
   {
      rpiConfigurations = {

        master =
          let system = "aarch64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "root";
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
      }; # rpiConfigurations

  };
}
