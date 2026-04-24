{
  ...
}:
{
  steppe.program._.communications = {
    includes = [
    ];
    nixos = { };
    homeManager =
      { pkgs, ... }:
      {
        home = {
          packages = with pkgs; [
            zulip
          ];
        };
        programs = {
          discord = {
            enable = true;
            settings = {
              SKIP_HOST_UPDATE = true;
            };
          };
          vesktop.enable = true;
        };
      };
  };
}
