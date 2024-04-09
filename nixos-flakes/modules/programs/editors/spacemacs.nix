{ home-manager, username, pkgs, ... }:
{
  home-manager.users.${username} = {
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
          rev = "4a227fc94651136a8de54bcafa7d22abe1fa0295";
          sha256 = "1zfmmzxaa8ym2nqx9ii6gvavy34x1826s4zsf9dhc98nx9zy16zs";
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    emacs
    sqlite
    cmake
    gcc
  ];

}

