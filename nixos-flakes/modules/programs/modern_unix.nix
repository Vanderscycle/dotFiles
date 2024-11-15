{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    eza # ls replacement
    fd # better find
    ripgrep # grep but easier
    silver-searcher # also known as ag
    jq # json parser
    yq # yaml parser
    zip
    httpie
    autojump # like zoxide
    tldr # quick tips
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
    nixpkgs-fmt
    nix-prefetch-git
    xfce.thunar # not unix but a really good
    xfce.tumbler
    gnumake # makefiles
  ];
}
