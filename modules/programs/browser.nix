{ inputs, ... }:
{
  steppe.program._.browser = {
    homeManager =
      { pkgs, ... }:
      {
        imports = [ inputs.zen-browser.homeModules.default ];
        programs = {
          zen-browser = {
            enable = true;
          };
          chromium = {
            enable = true;
            package = pkgs.vivaldi;
            commandLineArgs = [ ];
            extensions = [
              { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
              { id = "edibdbjcniadpccecjdfdjjppcpchdlm"; } # I still don't care about cookies
              { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
            ];
          };
        };
        home = {
          sessionVariables = {
            BROWSER = "vivaldi";
            DEFAULT_BROWSER = "vivaldi";
          };
        };
      };
  };
}
