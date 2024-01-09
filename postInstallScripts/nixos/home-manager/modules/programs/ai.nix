{  pkgs, ... }:
{
  home = {
    packages = with pkgs; [
    shell_gpt
    ];
  };
}
