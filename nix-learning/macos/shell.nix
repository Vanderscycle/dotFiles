{
  pkgs ? import <nixpkgs> { },
  ...
}:
pkgs.mkShell {
  name = "local dev shell";
  # desired packages
  nativeBuildInputs = with pkgs; [
    nodejs_20 # a pain point would be finding nodejs_16/18 as they aren't in the nixos packages list
  ];

  shellHook = ''
    ${pkgs.neofetch}/bin/neofetch
    echo -e "You are now in a dev shell in $(pwd)" | ${pkgs.lolcat}/bin/lolcat
    ${pkgs.figlet}/bin/figlet "node version:"
    node -v
  '';
}
