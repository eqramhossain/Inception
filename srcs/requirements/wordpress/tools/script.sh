#!/bin/bash

set -e

# mkdir -p /run/php
# mkdir -p /var/www/html/
#
# cd /var/www/html/
#
# if [ ! -f wp-load.php ]; then
#     wp core download --allow-root
# fi
#
# if [ ! -f wp-config.php ]; then
#     wp config create \
#         --allow-root \
#         --dbname="$DB_NAME" \
#         --dbuser="$DB_USER" \
#         --dbpass="$DB_PASSWORD" \
#         --dbhost="$DB_HOST" \
#         --skip-check
# fi
#
# until wp db check --allow-root >/dev/null 2>&1
# do
#     sleep 2
# done

exec "/bin/bash"
