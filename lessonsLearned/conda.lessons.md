# Conda

Save the conda env into a requirement.txt
```bash
conda list -e > requirements.txt
```
create a conda env (yes because I keep forgetting)
```bash
conda create -n <name-env> python {list packages}
```
and to delete it
```bash
conda remove -n <name-env>
```
update all the stale packages
```bash
conda update --all -y
```

