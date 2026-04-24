{ ... }:
{
  steppe.languages._.template = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          taplo # toml
          yaml-language-server # yaml
          vscode-json-languageserver # json
        ];
      };
  };
}
