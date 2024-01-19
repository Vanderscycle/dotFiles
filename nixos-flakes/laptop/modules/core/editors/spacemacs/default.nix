{ pkgs, ... }:
{
  programs = {
    emacs = {
      enable = true;
    };
  };

  home = {
    file.".emacs.d" = {
      # don't make the directory read only so that impure melpa can still happen
      # for now
      recursive = true;
      source = pkgs.fetchFromGitHub {
        owner = "syl20bnr";
        repo = "spacemacs";
        rev = "develop";
        sha256 = "0g7jvrimb1zsbiy3lcl9lbln7l9qv67jpvj2ifmxir3drxsjlr8n";
      };
    };
  };
}

