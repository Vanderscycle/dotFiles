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
        delta = {
          enable = true;
          options = {
            features = "decorations labels";
            zero-style = "8";
            navigate = "true";
            keep-plus-minus-markers = "true";
            decorations = {
              file-decoration-style = "none";
              whitespace-error-style = "22 reverse";
              file-style = "7 italic";
              hunk-header-style = "7";
              hunk-header-decoration-style = "8 ul";
            };
            labels = {
              file-modified-label = " MODIFIED ";
              file-removed-label = " REMOVED ";
              file-added-label = " ADDED ";
              file-renamed-label = " RENAMED ";
            };
          };
        };
        signing = {
          key = "AAAAC3NzaC1lZDI1NTE5AAAAIOYTNJEemZVjjyRY57nQRj4NHLL58aR1U5CyAsGtuUD3";
        };
      };
    };
  };
}
