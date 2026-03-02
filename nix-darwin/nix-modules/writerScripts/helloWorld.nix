{
  pkgs ? import <nixpkgs> { },
  config,
  lib,
  ...
}:
let
  hello-world = pkgs.writeShellScriptBin "hello-world" ''
    echo "hello world" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
  '';
in
{
  options = {
    script.hello-world.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Adds bash scripts showing a very simple hello world";
      default = true;
    };
  };

  config = lib.mkIf config.script.emacs.enable {
    environment.systemPackages = [
      hello-world
    ];
  };
}
