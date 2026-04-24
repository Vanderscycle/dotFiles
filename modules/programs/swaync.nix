{ ... }:
{
  steppe.program._.swaync = {
    homeManager =
      { pkgs, ... }:
      {
        services.swaync = {
          enable = true;
          package = pkgs.swaynotificationcenter;
        };
      };
  };
}
