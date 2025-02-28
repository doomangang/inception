FROM alpine:3.20

RUN apk update && \
  apk add --no-cache \
  mariadb mariadb-client

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# COPY ./tools/entrypoint.sh /
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
STOPSIGNAL SIGQUIT

VOLUME ["/var/lib/mysql"]

CMD ["mysqld"]