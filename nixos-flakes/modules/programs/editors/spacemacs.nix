{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs = {
      emacs = {
        enable = true;
      };
    };

    #   home = {
    #     file.".emacs.d" = {
    #       # don't make the directory read only so that impure melpa can still happen
    #       # for now
    #       recursive = true;
    #       source = pkgs.fetchFromGitHub {
    #         owner = "syl20bnr";
    #         repo = "spacemacs";
    #         rev = "a58a7d79b3713bcf693bb61d9ba83d650a6aba86";
    #         sha256 = "1h5q5ivy6vkl0199gkg2avrlrcbrq7gqykx6ncqygl0zfbv8i6qg";
    #       };
    #     };
    #   };
  };

  environment.systemPackages = with pkgs; [
    emacs-all-the-icons-fonts
    emacs
    libtool
    sqlite
    cmake
    gcc
  ];
}
