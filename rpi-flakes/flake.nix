{
  description = "My rpi k3s cluster configuration";

  inputs = {
    hosts.url = "github:StevenBlack/hosts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  };

  outputs = { self, nixpkgs, ... } @ attrs:
   {
      rpiConfigurations = {

        master =
          let system = "aarch64-linux";
          in nixpkgs.lib.nixosSystem {
            specialArgs = {
              username = "henri";
              hostname = "master";
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
              username = "henri";
              hostname = "worker";
              inherit system;
            } // attrs;
            modules = [
              ./.
            ];
          }; #worker
      }; # rpiConfigurations

  };
}
