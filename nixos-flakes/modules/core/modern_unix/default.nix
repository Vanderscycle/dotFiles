{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    eza # ls replacement
    bat # cat alternative
    fd # better find
    ripgrep # grep but easier
    ag # also caled silver surfer
    fzf
    jq # json parser
    yq # yaml parser
    httpie
    zoxide
    btop # htop but better
    zoxide
    tldr
    unzip
  ];
}
