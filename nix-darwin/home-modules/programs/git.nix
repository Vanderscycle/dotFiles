{ pkgs, ... }:
{
  programs = {
    #https://nix-community.github.io/home-manager/options.xhtml#opt-programs.gh.enable 
    gh = {
      enable = true;
    };
    #https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable 
    git = {
      enable = true;
    };
  };
}
