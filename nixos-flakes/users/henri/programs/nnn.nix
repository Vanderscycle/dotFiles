{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs = {
      nnn = {
        enable = true;
      };
    };
    home = {
      sessionVariables = {
        NNN_PLUG = "f:finder;o:fzopen;p:preview-tui;t:preview-tabbed"; # tabbed is x only
        NNN_OPTS = "Heda";
        NNN_TMPFILE = "/tmp/nnn";
        NNN_FIFO = "/tmp/nnn.fifo";
        NNN_BMS = "d:$HOME/Documents;D:$HOME/Downloads/;P:$HOME/Programs";
      };
    };
  };
}
