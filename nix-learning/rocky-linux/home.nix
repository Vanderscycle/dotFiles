{ pkgs, username, ... }:
{
  home = {
    username = username;
    packages = with pkgs; [
      cowsay
    ];

    file = { };

    sessionVariables = { };

    sessionPath = [ ];
  };

  programs = {
    home-manager.enable = true;
    eza = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    jq.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
    broot.enable = true;
  };
}
