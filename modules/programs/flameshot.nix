{ ... }:
{
  steppe.program._.flameshot = {
    homeManager =
      { pkgs, ... }:
      {
        services = {
          flameshot = {
            enable = true;
            package = (
              pkgs.flameshot.overrideAttrs (oldAttrs: {
                cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [ "-DUSE_WAYLAND_GRIM=ON" ];
              })
            );
            settings = {
              General = {
                showStartupLaunchMessage = false;
              };
            };
          };
        };
      };
  };
}
