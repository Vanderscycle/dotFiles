{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyperfine # how xz was discovered
    curlie # curl + httpie baby
  ];
  programs = {
    eza = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      catppuccin.enable = true;
    };
    jq.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
  };
}
