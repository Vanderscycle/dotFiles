# enables `nix run .#vm`. it is very useful to have a VM
# you can edit your config and launch the VM to test stuff
# instead of having to reboot each time.
{ inputs, den, ... }:
{

  den.aspects.temujin.includes = [ ];

  perSystem =
    { pkgs, ... }:
    {
      packages.temujinVm = pkgs.writeShellApplication {
        name = "temujinVm";
        text =
          let
            host = inputs.self.nixosConfigurations.temujin.config;
          in
          ''
            ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
          '';
      };
      packages.subutaiVm = pkgs.writeShellApplication {
        name = "subutaiVm";
        text =
          let
            host = inputs.self.nixosConfigurations.subutai.config;
          in
          ''
            ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
          '';
      };
    };
}
