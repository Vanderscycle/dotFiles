---
title: { { title } }
date: { { date } }
---
# {{title}}

## 

A playbook is a single `yml` file that contains one or more `plays` and one or more `tasks` per play. Each task has one or more modules. The ansible documentation is comprehensible enough to use as a reference point.
```yaml
- name: Update web servers #Play 1
  hosts: webservers # must match the invetory file
  remote_user: root

  tasks:
  - name: Ensure apache is at the latest version #Task 1
    ansible.builtin.yum:
      name: httpd
      state: latest
  - name: Write the apache config file #Task 2
    ansible.builtin.template:
      src: /srv/httpd.j2
      dest: /etc/httpd.conf

- name: Update db servers #Play 2
  hosts: databases
  remote_user: root

  tasks:
  - name: Ensure postgresql is at the latest version
    ansible.builtin.yum:
      name: postgresql
      state: latest
  - name: Ensure that postgresql is started
    ansible.builtin.service:
      name: postgresql
      state: started
```
## Common Commands
```bash
ansible-playbook <playbook.yml>
```
## Advanced 

You can create the role pattern where a common playbook (e.g. above) is called with roles.
```
- name: Update web and db servers
hosts: root
roles:
  - update
```

## References
* [Ansible Ref](https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html)

