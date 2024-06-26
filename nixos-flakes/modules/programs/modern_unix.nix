{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    eza # ls replacement
    fd # better find
    ripgrep # grep but easier
    silver-searcher # also known as ag
    jq # json parser
    yq # yaml parser
    httpie
    zoxide
    zoxide
    tldr
    unzip
    parted # remember about lslk
    usbutils
    tree
    dust # du
    duf # df
    hyperfine # how to find the xz weakness
    lsof
    sysz # systemctl + fzf
    killall
    wget
    curl
    firefox
    nixpkgs-fmt
    nix-prefetch-git
    xfce.thunar
    gnumake # makefiles
  ];
}
