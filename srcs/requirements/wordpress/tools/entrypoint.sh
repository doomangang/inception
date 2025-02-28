#!/bin/bash

echo Wordpress getting set...

apt-get -y update &&
apt-get -y upgrade &&
apt-get -y install \
php7.4 \
php-fpm \
php-cli \
wget \
curl \
php-mysql \
php-mbstring \
php-xml \
sendmail \
vim

service php7.4-fpm start;
apt-get -y install mariadb-client
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -f /var/www/html/wp-config.php ]; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp

  wp core download --allow-root --path=/var/www/html/
  wp core config --dbname=wp_db --dbuser=jihyjeon --dbpass=jihyjeon --dbhost=jihyjeon --dbprefix=wp_ --allow-root --path=/var/www/html/
  wp core install --url=https://jihyjeon.42.fr --title="jihyjeon's inception" --admin_user=jihyjeon --admin_password=jihyjeon --admin_email=jihyjeon@student.42seoul.kr --allow-root --path=/var/www/html/
  wp user create "mandoo" "sp0943@cau.ac.kr" --role=subscriber --user_pass="mandoo" --allow-root --path=/var/www/html/
fi
 
service php7.4-fpm stop;
echo Wordpress setting finished!
exec "$@"