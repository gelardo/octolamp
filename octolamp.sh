#!/bin/bash
echo 'Allowing PORTS' &&
sudo ufw allow 80 &&
sudo ufw allow 443 &&
echo 'Installing HTTPS Transport' &&
sudo apt-get install apt-transport-https -y &&
echo 'Adding ondrej/php repository' &&
sudo add-apt-repository ppa:ondrej/php &&
echo 'Refreshing APT Repositories' &&
sudo apt-get update -y &&
echo 'Uninstalling PHP'
sudo apt-get purge -y php* &&
read -p 'Enter the PHP Version you want to install: (e.g. 7.3)' phpversion
echo 'Installing PHP 7.4' &&
sudo apt-get install -y php$phpversion php$phpversion-common php$phpversion-fpm php$phpversion-mysql php$phpversion-pgsql php$phpversion-mbstring php$phpversion-xml php$phpversion-zip php$phpversion-gd libapache2-mod-php$phpversion php-pear curl php$phpversion-dev php$phpversion-ftp php$phpversion-iconv php$phpversion-imap php$phpversion-intl php$phpversion-pdo php$phpversion-posix php$phpversion-soap php$phpversion-imagick  &&
echo 'Configuring Apache' &&
sudo a2enmod php$phpversion &&
echo 'Restarting Apache' &&
sudo systemctl reload apache2 &&
echo 'Installing MariaDB' &&
sudo apt-get install -y mariadb-server mariadb-client &&
echo 'Starting MariaDB Server' &&
sudo systemctl start mariadb &&
echo 'Adding Apache2 & MariaDB to startup' &&
sudo systemctl enable apache2 &&
sudo systemctl enable mariadb &&
echo 'Configuring MySQL' &&
sudo mysql_secure_installation &&
echo 'Installing phpMyAdmin' &&
sudo apt-get install -y phpmyadmin &&
echo 'Please configure a new User for phpMyAdmin and Login.' &&
echo '-----------------------------------------------------------' &&
echo 'Server is ready!'
