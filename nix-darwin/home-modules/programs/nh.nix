{ pkgs, username, ... }:
{
  #https://github.com/LnL7/nix-darwin/pull/942
  # may have to wait a bit  for the merge otherwise check
  # this https://github.com/ToyVo/nh_plus?tab=readme-ov-file#nixdarwin-module
  home = {
    packages = with pkgs; [
      nh
      nvd
      nix-output-monitor
    ];
  };
}
