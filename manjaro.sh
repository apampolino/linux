#!/bin/sh

# set the best mirrors for download
pacman-mirrors -g

pacman -Syu

pacman -S yaourt htop screenfetch screen

# APACHE and PHP
pacman -S apache php-apache 

# MARIADB
pacman -S mariadb
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# SUPERVISOR
pacman -S supervisor

# REDIS
pacman -S redis-server

# UFW
pacman -S gufw
ufw allow 22
ufw allow 80
ufw allow 443
ufw allow 3306
ufw allow 9000
ufw allow 6379
ufw allow 11211

# extras
pacman -S filezilla chromium vlc

# ethernet parsing
pacman -S tshark tcpdump

# graphics driver
mhwd -i pci video-hybrid-intel-nvidia-390xx-bumblebee
usermod -aG bumblebee yourname

# try bumblebee
# optirun glxgears -info
# primusrun glxgears -info
# primusrun steam

# install sublime-text, go to www.sublimetext.com

# enable aur