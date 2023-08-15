---
title: {{ title }}
date: {{ date }}
---

# [PY] poetry-pyenv
`pyenv` allows us to change the python version while poetry manage the versioning of each python package in the same manner as pnpm using `package.json`

## pyenv
To install a new python version
```
pyenv install 3.x.x
```

## Poetry commands

Activate the env
```
poetry shell
```
if the python version is different than the system version.
```
poetry use 3.x
```
To leave the poetry shell
```
deactive
```

## References

