{ pkgs, username, ... }:
{

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.nushell;
  };
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    starship
  ];
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  # you need to install it manually
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  homebrew = {
    enable = true;
    casks = [
      "rectangle"
    ];
    brews = [
      "dive"
    ];
  };
}
