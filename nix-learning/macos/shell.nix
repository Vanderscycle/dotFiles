{
  inputs,
  pkgs ? import <nixpkgs> { },
  ...
}:
pkgs.mkShell {
  name = "local dev shell";
  # desired packages
  nativeBuildInputs = with pkgs; [
    nodejs_16
  ];

  shellHook = ''
    ${pkgs.neofetch}/bin/neofetch
    echo -e "You are now in a dev shell in $(pwd)" | ${pkgs.lolcat}/bin/lolcat
  '';
}
