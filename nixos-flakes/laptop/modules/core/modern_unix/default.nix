{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    eza # ls repalcement
    bat # cat alternative
    fd # better find
    ripgrep # grep but easier
    ag # also caled silver surfer
    fzf
    jq
    yq
    httpie
    zoxide
    dog # dig but way better
    btop # htop but better
  ];
}
