---
title: {{ title }}
date: {{ date }}
---

# [ANS] Roles

Main goal is to make the code reuseable accross organization or the web. To create a role from scratch use the galaxy command `ansible-galaxy init <name role>`.

The default location for roles is `/etc/ansible/roles` in `roles_path` inside the `ansible.cfg` but can be changed.
```toml
[default]
role_path:
```

## File structure
```
roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case
```
## Important commands

Creates an empty role dir
```bash
ansible-galaxy init <name role>
```

List the currently installed roles
```bash
ansible-galaxy list
```

Dumps the config, but must be done in the ansible env (same level ans the ansible.cfg)
```bash
ansible-config dump | rg ROLE
```

Override the role installation path.
```bash
# override
ansible-galaxy <name> -p <role location> 
```
It is important to add the roles folder in the gitignore so to now crowd the space.

## References
* [Ansible ref](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)
* [Ansible-galaxy](https://galaxy.ansible.com/) repo
* [ansible.cfg](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)
* [Ansible role path](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#default-roles-path)
