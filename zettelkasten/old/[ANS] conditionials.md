---
title: {{ title }}
date: {{ date }}
---

# [ANS] conditionials

Comes in really handed for using package managers. Can be used in loops and allows for greater flexibility.

## Examples
A simple condition.
```yaml
tasks:
  - name: Shut down Debian flavored systems
    ansible.builtin.command: /sbin/shutdown -t now
    when: ansible_facts['os_family'] == "Debian"
```
We can use `Registers` to use as conditionals for future commands.
```yaml
- name: Test play
  hosts: all

  tasks:

      - name: Register a variable
        ansible.builtin.shell: cat /etc/motd
        register: motd_contents

      - name: Use the variable in conditional statement
        ansible.builtin.shell: echo "motd contains the word hi"
        when: motd_contents.stdout.find('hi') != -1
```
## References
* [Ansible ref](https://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html)
