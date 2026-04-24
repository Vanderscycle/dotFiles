{ ... }:
{
  steppe.languages._.latex = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          texliveFull # latex client
        ];
      };
  };
}
