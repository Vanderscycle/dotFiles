{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # python311
        poetry
        pre-commit
        pyright
        (python311.withPackages (
          ps: with ps; [
            toml
            python-lsp-server
            isort
            black
            flake8
            boto3
            pyyaml
            awscli
          ];
        ))
      ];
    };
  };
}
