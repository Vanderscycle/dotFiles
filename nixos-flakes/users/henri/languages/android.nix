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
        # ios/android hell
        fastlane
        watchman
        android-studio
        # ruby
        ruby
        # java
        groovy
        jdk22
        maven
        gradle
      ];
    };
  };
}
