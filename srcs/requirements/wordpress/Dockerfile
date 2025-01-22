FROM alpine:3.21 

RUN apk update && apk add --no-cache \
    php82-cli \
    php82-fpm \
    php82-phar \
    php82-curl \
    php82-xml \
    php82-mysqli \
    php82-openssl \
    php82-json \
    php82-gd \
    php82-session \
    php82-dom \
    php82-mbstring \
    openssl \
    mariadb-client \
    bash \
    wget && \
    ln -sf /usr/bin/php82 /usr/bin/php

RUN mkdir -p /var/www/html && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY /tools/wordpress-init.sh /usr/local/bin
COPY /conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN chmod +x /usr/local/bin/wordpress-init.sh

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/wordpress-init.sh" ] 
