{ pkgs, home-manager, username, ... }:
{
  imports = [
    ./fish
    ./fonts
   # ./kitty
    ./starship
   # ./wezterm
  ];

  # ---- Home Configuration ----
  home-manager.users.${username} = {
    programs.git.enable = true;
    programs.vim.enable = true;
  };

  # ---- System Configuration ----
  programs = { };


  environment.systemPackages = with pkgs; [
    kitty
    wezterm
    btop
    vim
    fish
    git
  ];
}
