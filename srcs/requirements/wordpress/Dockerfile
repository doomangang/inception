FROM debian:bullseye

# RUN apt-get -y update && apt-get -y upgrade && apt-get -y install \
# php7.4 \
# php-fpm \
# php-cli \
# wget \
# curl \
# php-mysql \
# php-mbstring \
# php-xml \
# sendmail \
# mariadb-client \
# && rm -rf /var/lib/apt/lists/* \
# && mkdir /run/php

# RUN wget https://wordpress.org/wordpress-5.8.3.tar.gz \
# 	&& tar -xvzf wordpress-5.8.3.tar.gz \
# 	&& rm -rf wordpress-5.8.3.tar.gz

# RUN mkdir /var/www && \
# 	mv /wordpress /var/www/ && \
# 	chmod 777 /var/www/wordpress && \
# 	chown -R www-data:www-data /var/www/wordpress/* && \
# 	rm /var/www/wordpress/wp-config-sample.php

# COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d
# COPY ./tools/wp-config.php ./var/www/wordpress/


COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]