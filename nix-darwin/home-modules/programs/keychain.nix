{ pkgs, ... }:
{
  programs.keychain = {
    enable = true;
    keys = [
      "/users/henri.vandersleyen/.ssh/knak"
    ]; # make it x86_64-linux compliant too

  };
}
