{ pkgs, ... }:
# https://home-manager-options.extranix.com/?query=fzf&release=master
{
  programs = {
    fzf = {
      enable = true;
      catppuccin.enable = true;
    };

  };
}
