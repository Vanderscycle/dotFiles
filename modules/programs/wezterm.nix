{ ... }:
{
  steppe.program._.wezterm = {
    homeManager =
      { pkgs, ... }:
      {
        programs.wezterm = {
          enable = true;
          package = pkgs.wezterm;
        };
      };
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.wezterm
        ];
        # xdg.terminal-exec.settings.default = [ "org.wezfurlong.wezterm.desktop" ];
      };
  };
}
