---
title: {{ title }}
date: {{ date }}
---

# [ANS] Usage notes 1

## Installing roles

With the following structure:

```
.
├── ansible.cfg
├── inventory.yml
├── requirements.yml
├── secrets
│   └── linode.yaml
└── vm.yml

1 directory, 5 files
```

and the following ansible.cfg
```toml
[defaults]
inventory = inventory.yml
roles_path = <folder you are in>/roles
host_key_checking = false
```

Executing the following command will install all of the needed roles for your playbooks
```bash
ansible-galaxy install -r requirements.yml
```
## Using ansible-vault

With an encrypted variable file `linode.yaml`
```
- hosts: all
  vars_files:
    - secrets/linode.yaml
  tasks:
    - [...]
  roles:
    - [...]
```
You can, without decrypting the file, use as is

```bash
ansible-playbook <playbook.yml> -t <whatever,tags> --ask-vault-pass
```

If tired of doing so you can also decrypt the file but do not commit it.
```bash
ansible-vault decrypt <secret.yaml>
```
## References

