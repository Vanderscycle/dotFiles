{ ... }:
{
  steppe.program._.yazi = {
    homeManager =
      { pkgs, ... }:
      {
        programs = {
          yazi = {
            enable = true;
            shellWrapperName = "n";
            settings = {
              opener = {
                edit = [
                  {
                    run = ''nvim "$@"'';
                    block = true;
                    desc = "Edit with Neovim";
                  }
                ];
              };
              log = {
                enabled = false;
              };
              mgr = {
                show_hidden = true;
                sort_by = "mtime";
                sort_dir_first = true;
                sort_reverse = true;
              };
            };
          };
        };
      };
  };
}
