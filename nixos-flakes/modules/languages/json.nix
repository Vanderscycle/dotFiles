{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs = {
      go = {
        enable = true;
      };
    };
    home = {
      packages = with pkgs; [
        node2nix
        nil
        nixfmt-rfc-style
      ];
    };
  };
}
