{ ... }:
{
  steppe.program._.libreoffice = {
    homeManager =
      { pkgs, ... }:
      {
        home = {
          packages = with pkgs; [
            libreoffice
            hunspell
            hunspellDicts.en_US-large
          ];
        };
      };
  };
}
