---
title: {{ title }}
date: {{ date }}
---

# [ANS] Modules

There are different types of modules:
* System
* [Commands](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/command_module.html)
* Files
* Database
* Cloud providers
* More ...

If in the documentation the parameter `free_form` is specified that means that you can use the module name in the task. e.g. `command` module. A really usefull module is called `script` which allows ansible to mv && exec a script. Ansible playbook strive for [idempotency](https://en.wikipedia.org/wiki/Idempotence)

## examples
Command module
```yaml
# free-form (string) arguments, some arguments on separate lines with the 'args' keyword
# 'args' is a task keyword, passed at the same level as the module
- name: Run command if /path/to/database does not exist (with 'args' keyword)
  ansible.builtin.command: /usr/bin/make_database.sh db_user db_name
  args:
    creates: /path/to/database
# argv (list) arguments, each argument on a separate line, 'args' keyword not necessary
# 'argv' is a parameter, indented one level from the module
- name: Use 'argv' to send a command as a list - leave 'command' empty
  ansible.builtin.command:
    argv:
      - /usr/bin/make_database.sh
      - Username with whitespace
      - dbname with whitespace
    creates: /path/to/database
```

## References
* [Ansible Ref](https://docs.ansible.com/ansible/latest/plugins/module.html)
* [Ansible script](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/script_module.html#examples) module
* [Ansible lineinfile](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html) module e.g. append a line
* [Ansible service](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/service_module.html) module
