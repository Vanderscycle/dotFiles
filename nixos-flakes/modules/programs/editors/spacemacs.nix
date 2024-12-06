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
    libtool
    sqlite
    cmake
    gcc
    libgccjit
  ];
}
