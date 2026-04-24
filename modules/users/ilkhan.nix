{
  den,
  __findFile,
  ...
}:
{
  den.aspects.ilkhan = {
    includes = [
      # <den/primary-user>
      (den.provides.user-shell "fish")
      <steppe/theming>
      <steppe/program/browser>
      <steppe/shell>
      <steppe/program/kitty>
      # languages
      <steppe/languages/bash>
      # editors
      <steppe/program/vim>
    ];
    nixos = {
      users.users."ilkhan" = {
        openssh.authorizedKeys.keys = [
        ];
        extraGroups = [ "docker" ];
      };
      security.sudo.extraConfig = ''
        Defaults        timestamp_timeout=3600
      '';
      services = {
        displayManager = {
          autoLogin = {
            enable = true;
            user = "ilkhan";
          };
        };
      };
    };
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
