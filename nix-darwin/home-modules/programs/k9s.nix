{
  pkgs,
  ...
}:
# https://home-manager-options.extranix.com/?query=k9s&release=master
{
  programs.k9s = {
    enable = true;
    catppuccin.enable = true;
  };
}
