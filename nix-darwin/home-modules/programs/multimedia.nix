{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ytfzf
      vlc
    ];
  };
}
