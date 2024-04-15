{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    eza # ls replacement
    bat # cat alternative
    fd # better find
    ripgrep # grep but easier
    silver-searcher # also known as ag
    fzf
    jq # json parser
    yq # yaml parser
    httpie
    zoxide
    btop # htop but better
    zoxide
    tldr
    unzip
    parted # remember about lslk
    usbutils

    killall
    wget
    curl
    firefox
    nixpkgs-fmt
    nix-prefetch-git
    nnn
    xfce.thunar
  ];
}
