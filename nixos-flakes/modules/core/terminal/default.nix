{
  pkgs,
  home-manager,
  username,
  ...
}:
{
  imports = [
    ./shell
    ./fonts.nix
  ];

  # ---- Home Configuration ----
  home-manager.users.${username} = {
    programs.git.enable = true;
    programs.vim.enable = true;
  };
}
