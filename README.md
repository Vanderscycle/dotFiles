My .dotfile repo containing all relevant configurations that I use.

To use the post-install script for Ubuntu ssh into the Ubuntu server and type:
```bash
wget -O /etc/init.d/ https://raw.githubusercontent.com/Vanderscycle/ubuntu-dot-config/main/UbuntuPostInstall.sh && chmod +x UbuntuPostInstall.sh && bash UbuntuPostInstall.sh
``` 
It will however require a reboot.

The post install script installs the following programs:
* Postgresql
* MongoDB
* Docker
* Miniconda
* Oh-my-zsh (p10k theme)
