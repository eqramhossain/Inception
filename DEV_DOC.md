Inception — Developer Guide

Set up the project

1. Prepare a Debian virtual machine with Docker Engine, the Docker Compose  
plugin, Git, and Make installed. Make sure Docker is running.

2. Clone the project and enter its folder:

```
git clone https://github.com/eqramhossain/Inception.git
cd Inception
```

3. Create the .env file at the location used by your Compose file. Fill in  
the database settings, WordPress account details, and website domain.

4. Create the password files referenced under secrets in the Compose file.  
Keep .env and password files out of Git.

5. Create the host data folders listed in the Compose volume settings.

6. On the computer running your browser, add the VM’s IP address and  
ehossain.42.fr to /etc/hosts.

Build and start

From the project root, use the Makefile’s build/start target.  
If this is the default target, run:

make

You can also use Docker Compose directly:

docker compose -f srcs/docker-compose.yml up -d --build

The commands below assume the file is srcs/docker-compose.yml.  
Check this path and the Makefile targets against your project.

Useful commands

# Show all project containers

docker compose -f srcs/docker-compose.yml ps -a

  

# Read recent logs

docker compose -f srcs/docker-compose.yml logs --tail=50

  

# Stop the services

docker compose -f srcs/docker-compose.yml stop

  

# Remove project containers and network; keep named volumes

docker compose -f srcs/docker-compose.yml down

  

# List Docker volumes

docker volume ls

  

# Inspect one volume: replace VOLUME_NAME with its name

docker volume inspect VOLUME_NAME

Files and saved data

The cloned project folder contains the Makefile, Compose file, Dockerfiles,  
configuration files, and setup scripts.

Docker volumes keep application data outside the containers:

- WordPress files are stored at /var/www/html inside its container.
- MariaDB data is stored at /var/lib/mysql inside its container.
- The Compose volume settings show the matching folders on the VM.  

For this project, check that they are under /home/ehossain/data/.

Stopping or rebuilding containers keeps data stored in these volumes.  
Back up the data before removing volumes, deleting host data folders, or  
running a Makefile cleanup target. These actions may erase the website.

Docker command reference: https://docs.docker.com/reference/cli/docker/compose/
