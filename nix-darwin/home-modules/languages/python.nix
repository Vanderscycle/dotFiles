{
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      # python311
      poetry
      (python312.withPackages (
        ps: with ps; [
          python-lsp-server
          isort
          black
          flake8
        ]
      ))
    ];
  };
}
