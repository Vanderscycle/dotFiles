{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    git.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables git control";
      default = true;
    };

    git.userEmail = lib.mkOption {
      type = lib.types.str;
      description = "The email address used for git configuration.";
      default = null;
    };

    git.userName = lib.mkOption {
      type = lib.types.str;
      description = "The name used for git configuration.";
      default = null;
    };

    git.signingKey = lib.mkOption {
      type = lib.types.str;
      description = "The ssh key you want to sign your commits with.";
      default = null;
    };
  };

  config = lib.mkIf config.git.enable {
    programs = {
      gh = {
        enable = true;
      };
      git = {
        enable = true;
        userEmail = config.git.userEmail;
        userName = config.git.userName;
        extraConfig = {
          user.signingkey = config.git.signingKey;
          gpg = {
            format = "ssh";
          };
          commit.verbose = true;
          init = {
            defaultBranch = "main";
          };
        };
      };
    };
  };
}
