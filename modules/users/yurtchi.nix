{
  den,
  __findFile,
  ...
}:
{
  den.aspects.uurtchi = {
    includes = [
      # <den/primary-user>
      (den.provides.user-shell "fish")
      <steppe/program/browser>
      <steppe/shell>
      <steppe/program/kitty>
      # languages
      <steppe/languages/bash>
      # editors
      <steppe/program/vim>
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ vlc ];
        programs.ssh = {
          enable = true;
        };
      };
  };
}
