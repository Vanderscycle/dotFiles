{
  pkgs ? import <nixpkgs> { },
  config,
  lib,
  ...
}:
let
  emacs-env = pkgs.writeShellScriptBin "update-spacemacs-env" ''
    echo "hello world" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
  '';
in
{
  options = {
    script.emacs.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Adds bash scripts pertaining to emacs";
      default = false;
    };
  };

  config = lib.mkIf config.script.emacs.enable {
    environment.systemPackages = [
      emacs-env
    ];
  };
}
