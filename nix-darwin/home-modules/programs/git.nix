{
  lib,
  config,
  ...
}:
{
  options = {
    program.git.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables git control";
      default = true;
    };

    program.git.userEmail = lib.mkOption {
      type = lib.types.str;
      description = "The email address used for git configuration.";
      default = null;
    };

    program.git.userName = lib.mkOption {
      type = lib.types.str;
      description = "The name used for git configuration.";
      default = null;
    };

    program.git.signingKey = lib.mkOption {
      type = lib.types.str;
      description = "The ssh key you want to sign your commits with.";
      default = null;
    };
  };

  config = lib.mkIf config.program.git.enable {
    programs = {
      gh = {
        enable = true;
      };
      git = {
        enable = true;
        userEmail = config.program.git.userEmail;
        userName = config.program.git.userName;
        extraConfig = {
          user.signingkey = config.program.git.signingKey;
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
