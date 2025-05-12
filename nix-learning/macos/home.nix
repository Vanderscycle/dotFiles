{
  pkgs,
  config,
  username,
  ...
}:
{
  imports = [
    ./kitty.nix
    # you can separate your programs in separate folders
    ./programs
  ];

  # INFO: how to structure your code
  # https://www.youtube.com/watch?v=vYc6IzKvAJQ
  cowsay.enable = false;
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.05"; # Please read the comment before changing.

    packages = with pkgs; [
      # cowsay
    ];

    file = { };

    sessionVariables = { };

    sessionPath = [ ];

    # https://home-manager.dev/manual/23.05/options.html
  };

  programs = {
    home-manager.enable = true;
    eza = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    jq.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
  };
}
