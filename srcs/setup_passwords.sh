#!/bin/bash

if [ ! -d secrets ]; then
	mkdir secrets
fi

if [ ! -f ../secrets/db_password.txt ]; then
	openssl rand -base64 24 > ./secrets/db_password.txt
fi

if [ ! -f ../secrets/wp_admin_password.txt ]; then
	openssl rand -base64 24 > ./secrets/db_root_password.txt
fi
