{ __findFile, ... }:
{
  steppe.program._.git = {
    includes = [
      <steppe/program/lazygit>
    ];
    homeManager =
      { config, ... }:
      {

        sops.secrets."versionManagement/git/key" = { };
        sops.secrets."versionManagement/git/userEmail" = { };
        sops.secrets."versionManagement/git/userName" = { };
        programs = {
          git = {
            enable = true;
            lfs.enable = true;
            signing = {
              format = "ssh";
              key = config.sops.secrets."versionManagement/git/key".path;
              signByDefault = true;
            };
            ignores = [
              ".scratch"
              "*sync-conflict*"
            ];
            settings = {
              user.name = config.sops.secrets."versionManagement/git/userName".path;

              user.email = config.sops.secrets."versionManagement/git/userEmail".path;
              user.signingkey = config.sops.secrets."versionManagement/git/key".path;

              init.defaultBranch = "main";
              pull.rebase = true;
              rerere.enabled = true;
              column.ui = "auto";
              fetch.prune = true;
              interactive.singlekey = true;
            };
          };
        };
      };
  };
}
