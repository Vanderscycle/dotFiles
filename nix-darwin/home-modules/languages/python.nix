{
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      # python311
      poetry
      pyright
      (python312.withPackages (
        ps: with ps; [
          pip
          python-lsp-server
          isort
          black
          flake8
        ]
      ))
    ];
  };
}
