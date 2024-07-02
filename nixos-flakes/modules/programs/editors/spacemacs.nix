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
