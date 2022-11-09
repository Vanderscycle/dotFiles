---
title: {{ title }}
date: {{ date }}
---

# [ANS] loop

Using `with_` allows us to call the module commands in a loop. A few useful ones are:

* with_items
* with_file
* with_url
* with_mongodb

Each of the with can have multiple variables.

## examples

Super basic loop
```yaml
-
    name: 'Print list of fruits'
    hosts: localhost
    vars:
        fruits:
            - Apple
            - Banana
            - Grapes
            - Orange
    tasks:
        -
            command: 'echo "{{item}}"'
            with_items: '{{fruits}}'
```
Loop from a variable defined in anotherfile
```yaml
- name: Ensure groups exist
  ansible.builtin.group:
    name: "{{ group.name }}"
    state: present
  with_items: "{{ iam_groups }}"
  loop_control:
    loop_var: group
  when: iam_groups | length > 0
# in all.yml inside the `group_vars` folder
iam_groups:
  - name: bin
  - name: bar
  - name: bax
```
Loop with a register
```yaml
- name: Register loop output as a variable
  ansible.builtin.shell: "echo {{ item }}"
  loop:
    - "one"
    - "two"
  register: echo
- name: Fail if return code is not 0
  ansible.builtin.fail:
    msg: "The command ({{ item.cmd }}) did not have a 0 return code"
  when: item.rc != 0
  loop: "{{ echo.results }}"
```
## References
* [ansible ref](https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html)
* [with_](https://docs.ansible.com/ansible/latest/plugins/lookup.html#lookup-plugins) plugin
