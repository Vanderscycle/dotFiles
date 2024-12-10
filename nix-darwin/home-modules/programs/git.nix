{
  pkgs,
  desktop,
  hostname,
  ...
}:
{
  programs = {
    #https://nix-community.github.io/home-manager/options.xhtml#opt-programs.gh.enable
    gh = {
      enable = true;
    };
    #https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable
    git = {
      enable = true;
      userEmail = if hostname == "desktop" then "henri-vandersleyen@protonmail.com" else null;
      userName = if hostname == "desktop" then "vanderscycle" else null;
      extraConfig =
        if hostname == "desktop" then
          {
            user.signingkey = "~/.ssh/endeavourGit.pub";
            gpg = {
              format = "ssh";
            };
            commit.verbose = true;
            init = {
              defaultBranch = "main";
            };
          }
        else
          {
          };
    };
  };
}
