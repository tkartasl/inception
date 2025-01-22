#!/bin/sh
set -e

echo "Initializing MariaDB..."

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=root --datadir='/var/lib/mysql'

    /usr/bin/mariadbd-safe &
    temp_pid=$!

    for i in $(seq 1 120); do
        if mariadb-admin ping --silent; then
            break
        fi
        if [ $i -eq 120 ]; then
            echo "Error: MariaDB not available after 2 minutes."
            exit 1
        fi
        sleep 2
    done

    mariadb --user root <<EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';
DELETE FROM mysql.user WHERE user = '';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
FLUSH PRIVILEGES;
EOF

    /usr/bin/mariadb-admin shutdown --password="$DB_ROOT_PASSWORD"
else
    echo "MariaDB data directory already exists"
fi

echo "Starting MariaDB..."

exec /usr/bin/mariadbd-safe
