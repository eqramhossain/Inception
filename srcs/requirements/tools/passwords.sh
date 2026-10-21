#!/bin/bash

if [ ! -d ../secrets ]; then
	mkdir ../secrets
fi

if [ ! -f ../secrets/db_password.txt ]; then
	touch db_password.txt
	echo password into db_password.txt
fi

if [ ! -f ../secrets/wp_admin_password.txt ]; then
	touch wp_admin_password.txt
	echo password into db_password.txt
fi
