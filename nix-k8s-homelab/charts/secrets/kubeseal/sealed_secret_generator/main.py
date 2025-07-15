import os
import subprocess

rootDir: str = f"{os.environ['HOME']}/Documents/houseVanCyclesIndustries/infrastructure"
fileToSearch: str = "secret.yaml"
secretFilesPath: list[str] = []
kubesealCmd: list[str] = [
    "kubeseal",
    "--cert",
    f"{rootDir}/kubeseal-public.pem",
    "-o",
    "yaml",
    "-f",
]

for relPath, dirs, files in os.walk(rootDir):
    if fileToSearch in files:
        secretFilesPath.append(os.path.join(rootDir, relPath))

for secretPath in secretFilesPath:
    secretFile: str = f"{secretPath}/sealed-secret.yaml"
    print(secretFile, kubesealCmd + [f"{secretPath}/{fileToSearch}"])
    with open(secretFile, "w") as f:
        subprocess.run(kubesealCmd + [f"{secretPath}/{fileToSearch}"], stdout=f)
