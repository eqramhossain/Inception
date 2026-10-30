#!/bin/bash

set -e

if [ ! -f ./srcs/.env ]; then

	touch ./srcs/.env

	cat > "./srcs/.env" << 'EOF'
# mariadb environment variable
DB_NAME=wordpress
DB_USER=wpuser
DB_PASSWORD="$(cat /run/secrets/db_password)"
DB_PASSWORD_FILE=/run/secrets/db_password
DB_HOST=Mariadb:3306

# wordpress environment variable
WP_URL=https://ehossain.42.fr
WP_TITLE=Inception
WP_ADMIN_USER=Jhon
WP_ADMIN_PASSWORD="$(cat /run/secrets/wp_admin_password)"
WP_ADMIN_PASSWORD_FILE=/run/secrets/wp_admin_password
WP_ADMIN_EMAIL=jhonthedon@yopmail.com

WP_USER=bigboss
WP_USER_EMAIL=bigboss@yopmain.com
WP_USER_PASSWORD="$(cat /run/secrets/wp_user_password)"
EOF

fi
