{ config, pkgs, ... }:

let
  coolname = pkgs.python3Packages.buildPythonPackage rec {
    owner = "alexanderlukanin13";
    name = "coolname";
    doCheck = false;
    src = pkgs.fetchFromGitHub {
      owner = "${owner}";
      repo = "${name}";
      rev = "fd7efc2f843a2aa2218f156bfb1ad00f1481fe3c";
      sha256 = "11cf3q7j96hap5xl2jkby407skhlvg34cv9094lf3g4mj543v6pa";
    };
  };

  asgi-lifespan = pkgs.python3Packages.buildPythonPackage rec {
    owner = "florimondmanca";
    name = "asgi-lifespan";
    doCheck = false;
    propagatedBuildInputs = with pkgs.python310Packages; [ sniffio ];
    src = pkgs.fetchFromGitHub {
      owner = "${owner}";
      repo = "${name}";
      rev = "ff5d3d01340178a52946d35aec2e70384703955b";
      sha256 = "0njsa93my7rngzgycvnh7ipq6kb1lmbmync9j3bf8621l66a3hww";
    };
  };
  prefect = pkgs.python3Packages.buildPythonPackage rec {
    owner = "prefecthq";
    name = "prefect";
    doCheck = false;
    src = pkgs.fetchFromGitHub {
        owner = "${owner}";
        repo = "${name}";
        rev = "b0d56a62335540f934820212e1c3d184e685914f";
        sha256 = "JzBi6NEZGja7zosgbIywF/iHdMelTFDwOeZ9Unwm1rM=";
      };

    propagatedBuildInputs = with pkgs.python310Packages; [ poetry-core pip aiosqlite orjson alembic click cryptography typer apprise cloudpickle docker pendulum pytz pathspec fastapi readchar rich dateparser python-slugify uvicorn griffe fsspec coolname croniter jsonpatch asyncpg jsonschema graphviz kubernetes toml websockets asgi-lifespan h2];

    meta = {
      homepage = "https://github.com/PrefectHQ/prefect";
      description = "Prefect is a workflow orchestration tool empowering developers to build, observe, and react to data pipelines ";
      # license = stdenv.lib.licenses.apache;
    };
  };

in
{
  home.packages = with pkgs; [
    # python
    python310Full
    poetry
    pre-commit
    nodePackages.pyright

    python310Packages.black
    python310Packages.pyqt6
    python310Packages.yamllint
    python310Packages.pyyaml

    #user made
    prefect
  ];

}
