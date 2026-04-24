{
  steppe,
  __findFile,
  ...
}:
{
  steppe.shell = {
    # TODO: make a barebone one for ssh users
    includes = [
      <steppe/program/starship>
      <steppe/program/carapace>
      <steppe/program/nushell>
      <steppe/program/fish>
      <steppe/program/btop>
      <steppe/program/bat>
      <steppe/program/eza>
      <steppe/program/fzf>
      <steppe/program/zoxide>
      <steppe/program/atuin>
      <steppe/program/broot>
      <steppe/program/television>
      <steppe/program/yazi>
    ];
    nixos = { };
    homeManager =
      { pkgs, ... }:
      {
        home = {
          shellAliases = {
            ".." = "cd ../..";
            "..." = "cd ../../..";
            tree = "eza -T";
            ls = "eza -al";
          };
          packages = with pkgs; [
            silver-searcher # ag
            platinum-searcher # pt
            ripgrep
            ripgrep-all
            devenv
          ];
        };
        programs = {
          jq = {
            enable = true;
          };
          direnv = {
            enable = true;
            nix-direnv.enable = true;
          };
        };
      };
  };
}
