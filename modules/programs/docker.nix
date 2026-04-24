{ ... }:
{
  steppe.program._.docker = {
    nixos =
      { pkgs, ... }:
      {
        virtualisation = {
          docker = {
            enable = true;
            rootless = {
              setSocketVariable = true;
              enable = true;
            };
          };
        };
        networking = {
          firewall.trustedInterfaces = [
            "docker0"
          ];
        };
      };
  };
}
