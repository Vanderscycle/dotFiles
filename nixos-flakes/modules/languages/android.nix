{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      sessionVariables = {
        ANDROID_HOME = "$HOME/Android/Sdk";
      };
      sessionPath = [
        "$ANDROID_HOME/emulator"
        "$ANDROID_HOME/platform-tools"
      ];
      packages = with pkgs; [
        # android hell
        fastlane
        watchman
        android-studio

        # ruby
        ruby # for gemfiles
      ];
    };
  };
}
