{ pkgs, home-manager, username, ... }:
{
  imports = [
    ./shell
    ./fonts.nix
    ./kitty.nix
    ./starship.nix
  ];

  # ---- Home Configuration ----
  home-manager.users.${username} = {
    programs.git.enable = true;
    programs.vim.enable = true;
  };

}
