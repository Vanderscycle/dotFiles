{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bash-language-server # npm i -g bash-language-server
    shellcheck
    shfmt
  ];
}
