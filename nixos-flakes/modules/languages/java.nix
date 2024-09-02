{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # java
        groovy # linting of gradle files
        jdk22 # java
        maven
        gradle
      ];
    };
  };
}
