#!/bin/bash

set -e

mkdir -p /run/mysqld/
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /etc/mysql/
chown -R mysql:mysql /var/lib/mysql/

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

mariadbd --user=mysql &

until mariadb-admin ping --silent; do
    sleep 1
done

mariadb << EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;

CREATE USER IF NOT EXISTS '${DB_USER}'@'%'
IDENTIFIED BY '${DB_PASSWORD}';

GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.*
TO '${DB_USER}'@'%';

FLUSH PRIVILEGES;
EOF

exec "$@"
