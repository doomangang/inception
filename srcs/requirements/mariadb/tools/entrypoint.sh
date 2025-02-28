#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
  mysql_install_db
  /usr/share/mariadb/mysql.server start
  mysql -e "\
    CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; \
    CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_ROOT_PWD}'; \
    GRANT ALL ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%'; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PWD}'; \
    FLUSH PRIVILEGES; \
    "
  mysqladmin --user=root --password=$MARIADB_ROOT_PWD shutdown
fi

exec "$@"