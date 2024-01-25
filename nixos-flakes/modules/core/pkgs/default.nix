{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gh
    playerctl
    ripgrep
    unzip
    wget
    curl
    firefox
    nixpkgs-fmt
    nix-prefetch-git
    nnn

    # modern-unix
    eza # ls repalcement
    bat # cat alternative
    fd # better find
    ripgrep # grep but easier
    silver-searcher # also caled ag
    fzf
    jq
    yq
    httpie
    zoxide
    dog # dig but way better
  ];
}
