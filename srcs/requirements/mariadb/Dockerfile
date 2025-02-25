FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install mariadb-server && apt-get -y install vim

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d
# COPY ./tools/entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT [ "/entrypoint.sh" ]
COPY ./tools/createdb.sql /
RUN service mariadb start && mariadb < createdb.sql
RUN rm -f createdb.sql
CMD ["mysqld_safe"]