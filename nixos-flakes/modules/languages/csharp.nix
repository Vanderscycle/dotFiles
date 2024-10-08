{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        omnisharp-roslyn
        csharpier
        # dotnetCorePackages.dotnet_8.sdk
      ];
    };
  };
}
