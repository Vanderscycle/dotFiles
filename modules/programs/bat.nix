{ ... }:
{
  steppe.program._.bat = {
    homeManager =
      { pkgs, ... }:
      {
        programs.bat = {
          enable = true;
          # config.style = "plain";
          extraPackages = with pkgs.bat-extras; [
            prettybat
            batwatch
            batpipe
            batman
            # batgrep
            batdiff
          ];
        };
      };
  };
}
