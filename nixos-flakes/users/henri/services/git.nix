{
  username,
  home-manager,
  pkgs,
  ...
}:

{
  home-manager.users.${username} = {
    programs = {
      gh = {
        enable = true;
        settings = {
          git_protocol = "ssh";
          prompt = "enabled";
          aliases = {
            co = "pr checkout";
            pv = "pr view";
            pc = "pr create";
          };
        };
      };
      git = {
        enable = true;
        userEmail = "henri-vandersleyen@protonmail.com";
        userName = "vanderscycle";
        # commit = {
        #   gpgsign = true;
        # };
        aliases = {
          sig = "status --ignored";
        };
        extraConfig = {
          user.signingkey = "~/.ssh/endeavourGit.pub";
          gpg = {
            format = "ssh";
          };
          commit.verbose = true;
          init = {
            defaultBranch = "main";
          };
        };
        signing = {
          key = "AAAAC3NzaC1lZDI1NTE5AAAAIOYTNJEemZVjjyRY57nQRj4NHLL58aR1U5CyAsGtuUD3";
        };
      };
    };
  };
}
