echo '------------------------------------------------------------------------'
echo '=> Ubuntu 20.04LTS Factorio Headless Server'
echo '------------------------------------------------------------------------'
# https://www.reddit.com/r/factorio/comments/6qo2ge/guide_setting_up_an_ubuntu_headless_server/

echo -e '\n=> Update repository information '
sudo apt-get update -qq #-qq for quiet
echo -e '=> Perform system upgrade'
sudo apt-get dist-upgrade -y
echo -e 'Done.\n'

echo -e '\n=> Installing system utilities'
sudo apt-get install -y --no-install-recommends ufw fail2ban

echo -e '\n=> Configuring the firewall'
ufw allow openssh
ufw allow 34197/udp
ufw enable

dpkg-reconfigure tzdata

adduser gamemaster
