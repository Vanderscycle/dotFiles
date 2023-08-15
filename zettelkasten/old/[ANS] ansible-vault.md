---
title: {{ title }}
date: {{ date }}
---

# [ANS] ansible-vault

We can use GitOps pattern and store encrypted secrets in github using `ansible-vault`.

## Usefull commands
Assuming you created a yml file of format:
```yaml
BOB_SECRET_SAUCE: "ketchup"
```

```bash
ansible-vault encrypt <file.yml>
```

## References
* [Ansible-vault]()
