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
        NNN_OPTS = "Heda";
        NNN_TMPFILE = "/tmp/nnn";
        NNN_FIFO = "/tmp/nnn.fifo";
        NNN_BMS = "d:$HOME/Documents;m:/mnt/;D:$HOME/Downloads/;P:$HOME/Programs;c:$HOME/.config";
      };
    };
  };
}
