#!/bin/bash

set -e

cd /var/www/html/

if [ ! -f wp-load.php ]; then
    wp core download --allow-root
fi

if [ ! -f wp-config.php ]; then
    wp config create \
        --allow-root \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$DB_HOST" \
        --skip-check
fi

until wp db check --allow-root >/dev/null 2>&1
do
    sleep 2
done

if ! wp core is-installed --allow-root
then
    echo "Installing WordPress..."

    wp core install \
        --allow-root \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"
fi

chown -R www-data:www-data /var/www/html/

exec "$@"
