{ pkgs, home-manager, username, ... }:
{
  imports = [
    ./shell
    ./fonts
    ./kitty
    ./starship
  ];

  # ---- Home Configuration ----
  home-manager.users.${username} = {
    programs.git.enable = true;
    programs.vim.enable = true;
  };

}
