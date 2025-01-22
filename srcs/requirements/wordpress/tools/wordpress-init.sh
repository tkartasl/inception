#!/bin/bash
set -e

if [[ -z "$DB_HOST" || -z "$DB_NAME" || -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
    echo "Error: Missing required environment variables: DB_HOST, DB_NAME, DB_USER, DB_PASSWORD."
    exit 1
fi

if [[ -z "$HTTP_HOST" ]]; then
    export HTTP_HOST="$DOMAIN_NAME"
    echo "HTTP_HOST=$HTTP_HOST" >> /etc/environment
fi

for i in $(seq 1 120); do
    if mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;" &> /dev/null; then
        echo "MariaDB is ready!"
        break
    fi
    if [ $i -eq 120 ]; then
        echo "Error: MariaDB not available after 2 minutess."
        exit 1
    fi
    sleep 2
done

cd /var/www/html

if [ ! -f /var/www/html/index.php ]; then
        wp core download --allow-root
fi

if [ ! -f /var/www/html/wp-config.php ]; then  

	wp config create \
		--dbname="$DB_NAME" \
		--dbuser="$DB_USER" \
		--dbpass="$DB_PASSWORD" \
		--dbhost="$DB_HOST" \
		--allow-root
fi

if ! wp core is-installed --allow-root; then

	wp core install \
		--url="$DOMAIN_NAME" \
        	--title="$WORDPRESS_TITLE" \
        	--admin_user="$WORDPRESS_ADMIN_USER" \
        	--admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        	--admin_email="$WORDPRESS_ADMIN_EMAIL" \
        	--allow-root
fi

if ! wp user get "$WORDPRESS_USER" --allow-root > /dev/null 2>&1; then
    wp user create \
        "$WORDPRESS_USER" \
        "$WORDPRESS_USER_EMAIL" \
        --user_pass="$WORDPRESS_PASSWORD" \
        --allow-root
fi

echo "wordpress successfully initialized!"

exec php-fpm82 --nodaemonize
