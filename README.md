## mariadb configuration
- install services
apt-get update -y && \
apt-get upgrade -y && \
apt-get -y install mariadb-server vim

- modify server conf
vim /etc/mysql/mariadb.conf.d/50-server.cnf
# bind-addres  = 127.0.0.1

docker-compose exec -it mariadb sh       
apk add --no-cache bash
/bin/bash
apk update && \
  apk add --no-cache \
  mariadb mariadb-client

(COPY /conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf)
```
#
# These groups are read by MariaDB server.
# Use it for options that only the server (but not clients) should see

# this is read by the standalone daemon and embedded servers
[server]

# this is only for the mysqld standalone daemon
[mysqld]
user=mysql
pid-file=/var/run/mysqld/mysqld.pid
socket=/var/run/mysqld/mysqld.sock
port=3306
basedir=/usr
datadir=/var/lib/mysql
tmpdir=/tmp
lc-messages-dir=/usr/share/mysql

bind-address=0.0.0.0

# Galera-related settings
[galera]
# Mandatory settings
#wsrep_on=ON
#wsrep_provider=
#wsrep_cluster_address=
#binlog_format=row
#default_storage_engine=InnoDB
#innodb_autoinc_lock_mode=2
#
# Allow server to accept connections on all interfaces.
#
# bind-address=0.0.0.0
#
# Optional setting
#wsrep_slave_threads=1
#innodb_flush_log_at_trx_commit=0

# this is only for embedded server
[embedded]

# This group is only read by MariaDB servers, not by MySQL.
# If you use the same .cnf file for MySQL and MariaDB,
# you can put MariaDB-only options here
[mariadb]

# This group is only read by MariaDB-10.5 servers.
# If you use the same .cnf file for MariaDB of different versions,
# use this group for options that older servers don't understand
[mariadb-10.5]
```

[entrypoint.sh]
if [ ! -d /var/lib/mysql/wp_db ]; then
  mysql_install_db
  /usr/share/mariadb/mysql.server start
  mysql -e "\
    CREATE DATABASE IF NOT EXISTS wp_db DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; \
    CREATE USER 'jihyjeon'@'%' IDENTIFIED BY 'jihyjeon'; \
    GRANT ALL ON wp_db.* TO 'jihyjeon'@'%'; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY 'jihyjeon'; \
    FLUSH PRIVILEGES; \
    "
  mysqladmin --user=root --password=jihyjeon shutdown
fi

(ref for mariadb/Dockerfile)
```
FROM alpine:3.15.0

# install prerequisites
RUN apk update && \
  apk add --no-cache \
  mariadb mariadb-client

COPY /conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY tools/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
STOPSIGNAL SIGQUIT

VOLUME ["/var/lib/mysql"]

CMD ["mysqld_safe"]
```

php83-fpm php83-json php83-zlib php83-xml php83-xmlwriter php83-simplexml php83-pdo php83-phar php83-openssl \
  php83-pdo_mysql php83-mysqli php83-session \
  php83-gd php83-iconv php83-gmp php83-zip \
  php83-curl php83-opcache php83-ctype php83-apcu \
  php83-intl php83-bcmath php83-dom php83-mbstring php83-xmlreader php83-redis php83-tokenizer

  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
  chmod +x wp-cli.phar && \
  mv wp-cli.phar /usr/local/bin/wp && \
  ln -s /usr/bin/php83 /usr/bin/php && \
  adduser -D -H -u 82 -s /sbin/nologin www-data -G www-data

until mysql --host=mariadb --user=jihyjeon --password=jihyjeon -e '\c'; do
  echo >&2 "mariadb is unavailable - sleeping"
  sleep 1
done

echo >&2 "mariadb is up - start next wordpress bootstrap"

until redis-cli -h redis -a jihyjeon -e 'quit'; do
  echo >&2 "redis is unavailable - sleeping"
  sleep 1
done

echo >&2 "redis is up - start next wordpress bootstrap"

if ! wp core is-installed; then
  echo >&2 "wordpress is unavailable - start wordpress install"
  wp core download --locale=ko_KR --version=5.9.1
  wp config create \
    --dbname=$MYSQL_DB_NAME --dbuser=jihyjeon --dbpass=jihyjeon --dbhost=mariadb \
    --locale=ko_KR
  wp config set WP_REDIS_HOST redis
  wp config set WP_REDIS_PORT 6379 --raw
  wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME
  wp config set WP_REDIS_PASSWORD jihyjeon
  wp config set WP_REDIS_CLIENT phpredis
  wp core install \
    --url="$DOMAIN_NAME" --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" --admin_email="$WP_ADMIN_EMAIL" --admin_password="$WP_ADMIN_PASSWORD"
  wp plugin install redis-cache --activate
  wp user create --porcelain \
    "$WP_AUTHOR_USER" "$WP_AUTHOR_EMAIL" --role=author --user_pass="$WP_AUTHOR_PASSWORD"
  wp redis update-dropin
  wp redis enable
  chown -R 82:82 /var/www/html
fi

echo >&2 "wordpress is available - start $@"

exec "$@"