{ config, pkgs, ... }:
let
  theme = import ../themes;
in

{
  services = {
    mpd = {
      enable = true;
      musicDirectory = "/path/to/music";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';
    };
  };
}
