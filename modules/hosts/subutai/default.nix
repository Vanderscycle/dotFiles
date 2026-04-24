{
  den,
  inputs,
  __findFile,
  ...
}:
{
  den.aspects.subutai = {
    includes = [
      (den._.tty-autologin "ilkhan")
      <steppe/boot>
      <steppe/program/docker>
      <steppe/desktop-environment/xfce>
    ];
    nixos =
      { pkgs, ... }:
      {
        imports = with inputs; [
          nixos-hardware.nixosModules.gmktec-nucbox-g3-plus
          nixos-hardware.nixosModules.common-pc-ssd
        ];
        facter.reportPath = ./facter.json;
        environment.systemPackages = [ ];
        time.timeZone = "America/Vancouver";

        hardware = {
          bluetooth.enable = true;
        };

        services = {
          openssh = {
            enable = true;
          };
        };
        virtualisation.vmVariant = {
          virtualisation = {
            memorySize = 8192;
            cores = 4;
            graphics = true;
          };
        };
      };
  };
}
