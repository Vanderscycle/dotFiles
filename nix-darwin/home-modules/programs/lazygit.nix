{ pkgs, ... }:
# https://home-manager-options.extranix.com/?query=lazygit&release=master
{
  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
  };
}
