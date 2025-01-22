FROM alpine:3.21

RUN apk update && apk add \
    mariadb \
    mariadb-client \
    mariadb-common \
    bash

RUN mkdir -p /run/mysqld /var/lib/mysql /var/log/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql

    	
COPY conf/mariadb.cnf /etc/my.cnf.d/mariadb-server.cnf    
COPY tools/mariadb-init.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb-init.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "/usr/local/bin/mariadb-init.sh" ]
