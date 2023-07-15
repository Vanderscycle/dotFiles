{ config, pkgs, ... }: {
  programs.starship =
    let
      flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
    in
    {
      enable = true;
      settings = {
        # Other config here
        format = "$all"; # Remove this line to disable the default prompt format
        palette = "catppuccin_${flavour}";
      } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "3e3e54410c3189053f4da7a7043261361a1ed1bc"; # Replace with the latest commit hash
            sha256 = "11pfbly5w5jg44jvgxa8i0h31sqn261l27ahcjibfl5pb9b030dj";
          } + /palettes/${flavour}.toml));
    };
}
