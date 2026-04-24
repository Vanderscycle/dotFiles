{ ... }:
{
  steppe.program._.jujutsu = {
    homeManager =
      { config, pkgs, ... }:
      {
        sops.secrets."versionManagement/jj/key" = { };
        programs.jujutsu = {
          enable = true;
          settings = {
            user = {
              name = "temujin";
              email = "temujin@vandersleyen.xyz";
            };
            aliases.tug = [
              "bookmark"
              "move"
              "--from"
              "heads(::@- & bookmarks())"
              "--to"
              "@-"
            ];
            ui = {
              default-command = [
                "log"
                "--no-pager"
                "--reversed"
              ];
              show-cryptographic-signatures = true;
              diff-formatter = "difft";
            };
            git = {
              private-commits = "description(glob:'private:*')";
              write-change-id-header = true;
            };
            # TODO: fix the keys + rotate them
            signing = {
              behavior = "own";
              backend = "ssh";
              key = config.sops.secrets."versionManagement/jj/key".path;
            };
          };
        };
      };
  };
}
