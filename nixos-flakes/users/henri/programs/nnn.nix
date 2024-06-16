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
        NNN_PLUG = "f:finder;o:fzopen;v:imgview;p:preview-tui;t:preview-tabbed";
        NNN_OPTS = "Heda";
        NNN_TMPFILE = "/tmp/nnn";
        NNN_FIFO = "/tmp/nnn.fifo";
        NNN_BMS = "d:$HOME/Documents;D:$HOME/Downloads/;P:$HOME/Programs";
      };
    };
  };
}
