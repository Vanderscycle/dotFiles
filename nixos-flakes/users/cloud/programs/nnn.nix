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
        NNN_PLUG = "p:nuke";
        NNN_OPTS = "Hed";
        NNN_TMPFILE = "/tmp/nnn";
        NNN_FIFO = "/tmp/nnn.fifo";
        NNN_BMS = "d:$HOME/Documents;D:$HOME/Downloads/;P:$HOME/Programs";
      };
    };
  };
}
