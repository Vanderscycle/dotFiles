{ pkgs, username, ... }:
{
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.05"; # Please read the comment before changing.

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
