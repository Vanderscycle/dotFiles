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
          rev = "d84b01172d68f09791210d7de385f596ccf26b7";
          sha256 = "0367rpn4wkpb4zmwpfy7bfbxdwc6s2154hqwpmr9mnmj2k8fd43l";
        };
      };
    };
  };
environment.systemPackages = with pkgs; [
  sqlite
  cmake
  gcc
];

}

