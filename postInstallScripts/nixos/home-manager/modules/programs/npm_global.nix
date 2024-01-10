{ config, pkgs, ... }:

let
  devcontainersCli = pkgs.stdenv.mkDerivation {
    name = "devcontainers-cli";
    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/@devcontainers/cli/-/cli-0.55.0.tgz";
      sha512 = "U7wCt82wT3kB88dNCibUZiMfS8fw5T3iXHhqnss7d0oJsU5H42RwU4VgiT/Gx+xr+bGTReDWvw/zudsynyHozQ==";
    };
    buildInputs = [ pkgs.nodejs_18 ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out
      cp -r $src $out/package.tgz
      cd $out
      tar -xzf package.tgz --strip-components=1
      npm install --production
    '';
    meta = with pkgs.lib; {
      description = "Devcontainers CLI";
      homepage = "https://registry.npmjs.org/@devcontainers/cli";
      license = licenses.mit;
    };
  };
in
{
  home.packages = [
    devcontainersCli
  ];
}
