{ hostname, system ? "x86_64-linux",... }:

let
  # Fetch the colmena package.
  colmenaSrc = builtins.fetchTarball {
    url = "https://github.com/zhaofengli/colmena/archive/main.tar.gz";
  };

  # Import nixpkgs with your system choice.
  pkgs = import <nixpkgs> { inherit system; };

  # Import the colmena expression.
  colmena = import "${colmenaSrc}" {
    inherit pkgs;
  };
in
{
  # Define your deployment configurations.
  meta = {
    nixpkgs = pkgs;
    specialArgs = { inherit colmena; };
  };

  ${hostname} = {
    nixpkgs.system = "aarch64-linux";
    deployment = {
      buildOnTarget = true;
      targetHost = "master";
      targetUser = "master";
      tags = [ "rpi" ];
    };
  };
}
