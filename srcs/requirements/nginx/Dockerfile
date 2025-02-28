FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade && \
	apt-get -y install nginx &&\
	apt-get -y install openssl 

RUN openssl	req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/ssl/nginx.key \
		-out /etc/ssl/nginx.crt \
		-subj "/C=KR/ST=Seoul/L=Gaepo-dong/O=42Seoul/OU=./CN=jihyjeon.42.fr/emailAddress=jihyjeon@student.42seoul.kr"

COPY ./conf/default etc/nginx/sites-enabled/default
# COPY ./tools/entrypoint.sh /entrypoint.sh
# COPY ./conf/default /var/www/html/default
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
CMD [ "nginx", "-g", "daemon off;" ]