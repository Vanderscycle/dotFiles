{
  username,
  home-manager,
  pkgs,
  ...
}:
# https://home-manager-options.extranix.com/?query=fzf&release=master
{
  home-manager.users.${username} = {
    home = { };
    programs.ripgrep = {
      enable = true;
      arguments = [
        "--max-columns=150"
        "-max-columns-preview"
        "--smart-case"
        "-colors=line:none"
        "--colors=line:style:bold"
        "-glob=!git/*"
      ];
    };
  };
}
