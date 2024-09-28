{
  home-manager,
  username,
  pkgs,
  lib,
  ...
}:
let
  # https://github.com/NixOS/nixpkgs/pull/335923/files
  dbeaver-bin-custom = pkgs.dbeaver-bin.overrideAttrs (oldAttrs: {
    installPhase = ''
      runHook preInstall
      mkdir -p $out/opt/dbeaver $out/bin
      cp -r * $out/opt/dbeaver
      makeWrapper $out/opt/dbeaver/dbeaver $out/bin/dbeaver \
        --prefix PATH : "${pkgs.openjdk17}/bin" \
        --set JAVA_HOME "${pkgs.openjdk17.home}" \
        --prefix GIO_EXTRA_MODULES : "${pkgs.glib-networking}/lib/gio/modules" \
        --prefix LD_LIBRARY_PATH : "${
          lib.makeLibraryPath [
            pkgs.swt
            pkgs.gtk3
            pkgs.glib
            pkgs.webkitgtk
            pkgs.glib-networking
          ]
        }"
    '';
  });
in
{
  nixpkgs.config.packageOverrides = pkgs: { };
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # sql/db
        # dbeaver-bin-custom
        dbeaver-bin
        # github actions
        act
        # ansible
        # ansible
        # backend api calls
        insomnia
        # dns
        dogdns
        nssmdns # for local rpi cluster
      ];
    };
  };
}
