{
  username,
  home-manager,
  pkgs,
  ...
}:

{
  home-manager.users.${username} = {
    programs = {
      git = {
        enable = true;
        signing = {
          key = "AAAAC3NzaC1lZDI1NTE5AAAAIOYTNJEemZVjjyRY57nQRj4NHLL58aR1U5CyAsGtuUD3";
        };
      };
    };
  };
}
