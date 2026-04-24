{ ... }:
{
  steppe.languages._.typescript = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nodejs_22
          bun
          typescript-language-server
          typescript
          prettier
          eslint
        ];
      };
  };
}
