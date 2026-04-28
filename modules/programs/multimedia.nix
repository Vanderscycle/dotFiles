{
  ...
}:
{
  steppe.program._.multimedia = {
    nixos = { };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          vlc
          nomacs
          feishin # TODO: find a way to have offline saved music in nas
        ];
      };
  };
}
