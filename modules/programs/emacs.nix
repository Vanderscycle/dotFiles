{ ... }:
{
  steppe.program._.emacs = {
    nixos = {
      services.emacs = {
        enable = true;
      };
    };
    homeManager =
      { config, pkgs, ... }:
      # nix-prefetch-github syl20bnr spacemacs --rev develop
      {
        home = {
#          file = {
#            ".emacs.d" = {
#              source = pkgs.fetchFromGitHub {
#                owner = "syl20bnr";
#                repo = "spacemacs";
#                rev = "4eecc8efe30fdfcbd56c07af66205cfaf0aa967a";
#                sha256 = "8JyOZq/Of9pacXAfoHqW3M2kJw08NzIggx2xTdPdmLk=";
#              };
#            };

#            ".spacemacs.d" = {
#              source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotFiles/.config/.spacemacs.d";
#            };
#          };
        };
      };
  };
}
