{pkgs, ...}:
{
      packages = with pkgs; [
        #yaml
        nodePackages.yaml-language-server
      ];
}