{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs =
      {
      };
    home = {
      packages = with pkgs; [
        nixos-anywhere
        nil
        nixfmt-rfc-style
      ];
    };
  };
}
