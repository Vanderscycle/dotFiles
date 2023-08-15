---
title: {{ title }}
date: {{ date }}
---

# [ANS] variables

Store information that varies between each hosts. Think of `values.yaml` of a helm chart. You can store them in a yml file with the same name as the host (e.g. `hosts: web` -> `web.yml`}). Ansible uses jinja2 templating.

## YAML && jinja2
Due to the templating limit, j2 variables must be enclosed in valid YAML strings.

## References
* [Ansible ref](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html)
* [jinja2](https://palletsprojects.com/p/jinja/)
