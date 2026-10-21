This project has been created as part of the 42 curriculum by ehossain

### Description

Inception is a 42 project that teaches the basics of system administration  
with Docker. The goal is to build and run a WordPress website inside a  
virtual machine, with each service in its own container.

The project uses three services:

- NGINX handles HTTPS connections on port 443 using TLS 1.3.
- WordPress and PHP-FPM run the website.
- MariaDB stores the website’s posts, users, and settings.

Each service is built from a custom Dockerfile. Docker Compose connects the  
services through a Docker network. Two named volumes keep the database and  
WordPress files, even when the containers are removed.

This project helps me understand how containers, networks, storage, and  
password management work together. Packaging services with their dependencies  
also makes the setup easier to run on another machine.

#### Virtual Machine vs Docker

A virtual machine runs its own operating system and kernel. Docker containers  
share the host’s kernel, so they usually need fewer resources and start faster.  
In this project, Docker runs inside a Debian virtual machine.

#### Secrets vs Environment Variables

Environment variables hold settings such as database names and the website  
address. Secrets provide passwords as files inside the containers that need  
them. With Docker Compose, the original secret files must still be protected  
on the host and kept out of Git.

#### Docker Network vs Host Network

A Docker bridge network lets the containers communicate using their service  
names, while keeping their network separate from the host. Host networking  
shares the host’s network directly. This project uses a Docker network and  
publishes only NGINX’s port 443.

#### Docker Volumes vs Bind Mounts

A named volume is storage managed through Docker. A bind mount connects a  
specific host file or folder directly to a container. Both can keep data after  
a container is removed. This project uses two named volumes, with their data  
stored under /home/ehossain/data on the virtual machine.

### Instructions

1. Install the tools

This project uses Debian. Install Docker Engine and the Docker Compose plugin  
by following the [official Debian installation guide](https://docs.docker.com/engine/install/debian/).  
Docker Desktop is not required.

Install Git and Make as well:

sudo apt update

sudo apt install git make

2. Download and configure the project

git clone https://github.com/eqramhossain/Inception.git

cd Inception

Before starting:

- Create the .env file with the settings required by the Compose file.
- Create the secrets folder and the password files referenced by Compose.
- Create the data folders required by the volume configuration under /home/ehossain/data.
- Add the VM’s IP address and ehossain.42.fr to /etc/hosts on the computer  
where you will open the website.

See DEV_DOC.md for setup details and  
USER_DOC.md for daily use. Do not commit passwords to Git.

3. Build and run

From the project folder, run the Makefile’s build/start target. If it is the  
default target, use:

make

The Makefile should build the images and start the services with Docker Compose.

4. Open the website

- Website: https://ehossain.42.fr
- Admin panel: https://ehossain.42.fr/wp-admin

Log in with the WordPress admin account configured during setup. A self-signed  
certificate may cause a browser trust warning.

### Questions
#### What is Docker ?
Wikipedia defines Docker as

	an open-source project that automates the deployment of software applications inside containers by providing an additional layer of abstraction and automation of OS-level virtualization on Linux.

In simpler terms `docker` is a tool that allow developper and sys-admin to easily deploy and host application in an isolated environment called `containers` to run on the host OS.  The key benefit of Docker is that it allows users to package an application with all of its dependencies into a standardized unit for software development.

#### What is a Container ?
A Container is an isolated runtime environment for an application and processes that contains everything to run an application - including code, libraries and settings isolated from the rest of the system.

Containers share the host kernel instead of running a full separate OS. 
Each container has its own filesystem, own network, processes which act like a mini computer which does not consume too much resources.


Why Containers ? 
Fast : They boot and load instantly cause they don't load an entire OS
Portable: They can run reliably across different computers, servers and cloud environment
Efficient: They use far more less memory and cpu than tradation VM.

#### What is a container Image ?
A container image is a standardized package that includes all of the files, binaries, libraries, and configurations to run a container. Think of it like a blueprint of your container. For a PostgreSQL image, that image will package the database binaries, config files, and other dependencies.

#### What is a Docker image ?
An image is a template used to create containers. Think of it like a read-only file that contains everything an application needs to run. This includes the code, runtime, system tools and libraries.

#### What is a Docker container ?
A Docker container is fundamentally a collection of processes running on the host Linux Kernel, but isolated from other processes. A live isolated environment where an application actually executes which is created from an running image.


#### Image vs Container
A Docker image is essentially a packeged filesystem plus metadata describing how it should be run. In the other hand a blueprint for the container.

On the other hand A instance created from the Image is called a container.


#### What is a dockerfile ?

A dockerfile is a recipie for building an image. The file that contains all the cmd and instruction to build an image called a dockerfile. 

so here is an workflow 
```
Dockerfile (instruction for build an image)
    ↓
   docker build
    ↓
Docker image (blueprint for containers)
    ↓
   docker run
    ↓
Docker container (isolated environment for applications)
```


#### What is a Docker compose ?
Docker compose is a tool developed by Docker for defining and running multi-container applications using a single YAML configuration file. 

Docker Compose maps out your entire infrastructure in a blueprint file typically named `compose.yaml` or `docker-compose.yml` built around three foundational components
- Services 
- Network
- Volumes

#### What is a dockerhub ?
Dockerhub is a a cloud-based registry service where developers store, manage, and share container images. It is like github for docker, instead of `git clone` we do `docker pull` download pre build images.

#### What is a volume ?
Volumes are persistent data stores for containers, created and managed by Docker.
[here is more about it.](https://docs.docker.com/engine/storage/volumes/)

#### What is a docker-network ?
Docker networking is a built-in feature of Docker that enables isolated containers to communicate with each other, the host machine, and external networks like the internet. By default, Docker completely isolates a container's network stack. Docker networks act as the virtual "roads and switches" that securely bridge that isolation based on your architecture needs.
[here is more about it](https://docs.docker.com/engine/network/)

#### What is Docker secrets ?
Docker Secrets is a native mechanism used to securely store and manage sensetive data - such as API keys, passwords, database credentials and SSL certificates.
By default, Docker decrypts secrets and mounts them as read-only files inside the container at memory-based paths: /run/secrets/<secret_name> on Linux. When the container stops, the decrypted secret is completely wiped from memory.
[here is more about it](https://docs.docker.com/engine/swarm/secrets/)

#### What is a deamon ?
A daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user. They run invisibly without a graphical user interface or a control terminal. They starts when the os system boot and run until shuts down. They are detached from all user interactions.

example of some daemons are, `sshd` `dockerd` `syslogd` `httpd` `systemd` - the pid1.

#### What is PID 1 and why does it matter for docker containers ?

#### What is the difference between a background process and a foreground process


---

add user to `docker gourp` so we can use it without calling `sudo` everytime. `docker` need root permission any user added to `docker group` will have `root` privilege so be cautious.

# Docker Commands CLI

to build an image for a specefic system 
`docker build --platform linux/amd64 --no-cache -t my_image_name /path_to_Dockerfile_folder`

of from a specific `Dockerfile`
`docker build --platform linux/amd64 --no-cache -t my_image_name -f /path_to_Dockerfile  .`

to inspect a docker container 
`docker inspect cmd`

`docker ps -a` to see all the current running processec by docker 


`docker run` command 

to mount a docker volume
`--mount source=my_volume,target=/var/www/html/`

to prevent unwanted packages installation.
`--no-install-recommends`

`-v my_website_files_volume:/var/www/html/`

to kill all the container  that is exited 
`docker rm $(docker ps -a -q -f status=exited)` or `docker container prune`

to kill all the image
`docker rmi -f $(docker ps -aq)`

how to execute an interactive shell in a docker container 
`docker exec -it <container_name/id> /bin/bash`
	- `-i` interactive
	- `-t` tty

to build a docker image without cache 
`docker build --no-cache -t name_container /path_to_file`

to run a container to restart automatically 
`docke run -d --restart unless-stoped --name docker_conatiner docker_image`

to update an existing container 
`docker update --restart unless-stopped --name docker_container_id/name`

create a docker volume
`docker volume create my_volume`

remove a docker volume
`docker volume rm my_volume`

to inspect a docker volume
`docker volume inspect my_volume`

to list all the docker volumes
`docker volume ls`

to remove all the unused docker volume
`docker volume prune`

override environment variables at runtime using `docker run -e APP_ENV=test` 

inspect docker logs `docker logs <container_id>`

inspect history of a docker images `docker image history image_id/name`

The `docker run --rm` cmd automatically removes the container form your system as soon as it exits or stops running.

to mount a volume with the `docker run`
```
docker run --mount type=volume,src=<volume-name>,dst=<mount-path>
```

check a container logs
```
docker container logs container_name/id
docker container inspect container_name/id
```

To restart a existing container automatically 
```
docker stop container
docker update --restart=always container_name/id
```

While creating a container 
```
docker run -d --restart=always  -p 443:443 --mount source=website_files,target=/var/www/html/ --name NGINX nginx_image:Inception
```

how to connect a existing container to a network
```
# create a network
docker network create my_network
docker network connect my_network container_id/name
```

to see all the running process inside a container
```
docker exec container_name ps aux
```



# Docker Volumes

### What is Named Volumes
in Docker, a **named volume** is a persistent data storage mechanism that is completely created and managed by the Docker engine. Unlike container filesystems, which are completely wiped out when a container is deleted, a named volume exists independently of any single container's lifecycle.

You give a named volume a distinct, human-readable name (like `db_data` or `app_logs`). Docker then allocates a dedicated space for it inside a protected directory on the host machine (usually `/var/lib/docker/volumes/` on Linux)

Create a docker volume
```shell
docker volume create my_volume
```

List volumes
```shell
docker volume ls
```

Display detailed infos
```shell
docker volume inspect name_vl
```

Remove a volume
```
docker volume remove name_vl
```



```Shell
# 1. Create the directories on your host first (Docker won't auto-create them this way)
mkdir -p /home/your_username/data/volume_one
mkdir -p /home/your_username/data/volume_two

# 2. Create the named volumes pointing to those directories
docker volume create --driver local \
  --opt type=none \
  --opt o=bind \
  --opt device=/home/your_username/data/volume_one \
  volume_one

docker volume create --driver local \
  --opt type=none \
  --opt o=bind \
  --opt device=/home/your_username/data/volume_two \
  volume_two
```

`--driver local`  is docker built in volume driver. It uses storage available on the docker host
`--opt type=none`  specifies the mount type used by the Linux mount operation.

`---opt o=bind`  is the value passed to the Linux mount operation, requesting a bind mount.
A bind mount makes an existing directory accessible at another location in the filesystem.

`--opt devide=/path` device tells the local driver which host directory to use as the source of the bind mount.

# Dockerfile

A Dockerfile is a plain text file that contains a series of instructions used to build a Docker image. Dockerfiles supports following keywords.

| Instruction | Description                                               |
| ----------- | --------------------------------------------------------- |
| ADD         | Add files to the container                                |
| ARG         | Build time arguments                                      |
| CMD         | Default commands to run                                   |
| COPY        | Copy files and directories                                |
| ENTRYPOINT  | Default executable path                                   |
| ENV         | Environment variables                                     |
| EXPOSE      | Specify listening ports                                   |
| FROM        | Specify base image                                        |
| HEALTHCHECK | Check a container health on startup                       |
| LABEL       | Add metadata to an image                                  |
| MAINTAINER  | Specify author of an image                                |
| ONBUILD     | Custom instructions for when the image is used in a build |
| RUN         | Execute build commands                                    |
| SHELL       | Set defaults shell of an image                            |
| STOPSIGNAL  | Specify the system call signal for exiting a container.   |
| USER        | Set user and group ID.                                    |
| VOLUME      | Create volume mounts.                                     |
| WORKDIR     | Change working directory.                                 |

### FROM

`FROM` tells docker which existing image to use as the starting for a new image.

Example:
```dockerfile
FROM debain:bookworm-slim
```

This tells Docker Start with the Debian Bookworm image. I will install and configure my application on top of it. `FROM` normally appears at the beginning of a `Dockerfile` although certain build instruction such as `ARG` can appear before it.


### RUN - Execute command when building the image

`RUN` tells Docker to execute a command during the image-building process.

 Generally used to install software, create directories, configure files, and prepare any dependencies needed for an application to run.

Example:
```Dockerfile
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx
```

Note: Every `RUN` commands create a layer in the container.

### CMD - Define the default command when a container starts

`CMD` specifies the default command that Docker should execute when you start a container from your image.

This is different from `RUN`.
- `RUN` executes during image construction.
- `CMD` specifies what executes when a container starts.

Example:
```Dockerfile
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx

CMD ["nginx", "-g", "daemon off;"]
```

whenever we will run a container using the `docker run` command it will run `nginx -g 'daemon off;'` in the container.

### COPY - Copy files into the image

`COPY` copies files or directories into your Docker image. Imagine there is a index.html at the root of the current directory and we will copy this into the nginx server.

Example:
```Dockerfile
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx

COPY index.html /var/www/html/index.html

CMD ["nginx", "-g", "daemon off;"]
```

### ADD - Copy files with extra capabilities

To add files from host to container working directory. 

It can:
- Copy files and directories into the image.
- Automatically extract local tar archives.
- Download files from a URL.
- Retrieve files from supported remote Git repositories.

Example:
```Dockerfile
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx

COPY website.tar.gz /var/www/html/index.html

CMD ["nginx", "-g", "daemon off;"]
```

### ARG - Define variables for the image build

`ARG` defines a variable that is available during the image-building process. You can give it a default value or provide a different value when building the image.

Example:
```Dockerfile
FROM debian:bookworm-slim

ARG APP_VERSION=1.0

RUN apt-get update && apt-get install -y nginx

COPY website.tar.gz /var/www/html/index.html

CMD ["nginx", "-g", "daemon off;"]
```

it can also be passed while building an image with `docker build`
```shell
docker build --build-arg APP_VERSION=2.0 -t my_app .
```


### ENV - Define environment variables

`ENV` defines an environment variable that is available during the image build and also persists in containers created from that image. An environment variable is a named value that a program or script can read.


Example:
```Dockerfile
FROM debian:bookworm

ENV APP_NAME=Inception

CMD ["sh", "-c", "echo $APP_NAME"]
```

Build it:
```shell
docker build -t my_app .
```

Run it normally:

```shell
docker run --rm my_app
Output:
Inception
```


Now override the variable:
```shell
docker run --rm -e APP_NAME=WordPress my_app
Output:
WordPress
```

The `-e` option lets you provide an environment variable when creating a container. Useful to store confidential information in `.env` file

### EXPOSE - Document the container's network port

`EXPOSE` tells Docker and other developers which network port your application is expected to listen on. 

Example:
```Dockerfile
FROM debian:bookworm-slim

ARG APP_VERSION=1.0

RUN apt-get update && apt-get install -y nginx

COPY website.tar.gz /var/www/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

This indicates that the application is expected to listen on `TCP` port `80`. 

However, there is an important detail:
EXPOSE does not publish a port on your host machine. It does not automatically let you access the container using localhost:80. How do I access the container from my host?
You can publish its port when you start it:

```shell
docker run -d -p 8080:80 my_nginx
```

The `-p` option publishes a port. The command maps host port 8080 to container port 80.
You can then access NGINX at:

```
http://localhost:8080
```


### ENTRYPOINT — Define the container's main executable

`ENTRYPOINT` defines the executable that a container is designed to run. At first, it can look almost identical to `CMD`, because both can specify a command that runs when a container starts.

The key difference is how `Docker` treats them when you supply additional arguments at runtime. `ENTRYPOINT` defines the main executable; `CMD` can supply default arguments for that executable.
[Choosing Between RUN, CMD, and ENTRYPOINT](https://www.docker.com/blog/docker-best-practices-choosing-between-run-cmd-and-entrypoint/)

Example:
```Dockerfile
FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y nginx

COPY ./tools/start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
```


### HEALTHCHECK - Check whether your application is working

A container can be running even when the application inside it is not working correctly. For example, suppose an `NGINX` process exists but cannot respond to `HTTP` request. `Docker` might show the container as running because its main process has not exited. `HEALTHCHECK` allows you to define a command that tests whether the application is functioning.

Example:
```Dockerfile
FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y nginx curl

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD curl -fsS http://127.0.0.1/ > /dev/null || exit 1

CMD ["nginx", "-g", "daemon off;"]
```

 --interval=30s  Run a healthcheck every 30 seconds
--timeout=5s  Fail a check if it takes more than 5 seconds
--retries=3  Mark the container unhealthy after three consecutive failures 
CMD Specify the command used for the healthcheck
curl -fsS Make an HTTP request and report HTTP errors
http://127.0.0.1/ Test NGINX through the container's own loopback interface 
`>` /dev/null Discard the normal response body 
exit 1 | Return an error if the request fails

We installed curl explicitly because the healthcheck command depends on it.

### LABEL - Add metadata about image

`LABEL` attaches metadata to your Docker image. Metadata is additional information describing something. You can use labels to indicate an image's purpose, version, maintainer, or associated project.

Example:
```Dockerfile
FROM debian:bookworm

LABEL org.opencontainers.image.title="Inception NGINX" \
      org.opencontainers.image.description="NGINX service for Inception" \
      org.opencontainers.image.version="1.0"
```

to inspect 
```shell
docker image inspect image_name/id
docker image inspect --format '{{json .Config.Labels}}' my_nginx
```

### MAINTAINER - Identify the image's maintainer

`MAINTAINER` was traditionally used to identify the person or organization maintaining a Docker image. This instruction is deprecated in favor of using label.

Example:
```Dockerfile
FROM debian:bookworm
MAINTAINER "Example Developer <developer@example.com>"
```


### SHELL - Change the default command interpreter

Example:
```Dockerfile
SHELL ["/bin/bash", "-c"]
```


### STOPSIGNAL _ Choose the signal used to stop a container

`Docker` sends a signal to the container's main process. A signal is a message sent to a process to request an action, such as stopping or terminating. By default, `Docker` uses `SIGTERM`, unless the image or container specifies another stop signal. `STOPSIGNAL` allows you to change that default.

Example:
```Dockerfile
STOPSIGNAL SIGQUIT
```


### USER - Choose which user runs commands inside the image
By default, `Dockerfiles` that do not specify a user commonly run build commands and the container's main process as root, depending on the base image's configuration.

`USER` lets you change the user that executes subsequent `RUN` instructions and the user used for `CMD` or `ENTRYPOINT` at runtime.

Example:
```Dockerfile
FROM debian:bookworm

RUN useradd -m appuser

USER appuser

CMD ["whoami"]

```

run it:
```shell
docker run --rm
```


### VOLUME - Declare a directory intended for persistent storage

`VOLUME` declares a directory in the container that should be backed by externally managed storage. You have already encountered `Docker` volumes, so this instruction is particularly important to understand.

First: Why do we need volumes?
A container has its own writable filesystem. If you write a file inside the container and then remove that container, changes stored only in its writable layer are lost. A `Docker` volume allows data to exist independently of a particular container.

For example, `MariaDB` stores databases on disk. You do not want all your database data to disappear every time you remove and recreate its container. A volume allows your new `MariaDB` container to use the same persistent database files.

Example:
```Dockerfile
VOLUME ["/app/data"]
```

When you create a container from this image, Docker creates an anonymous volume for this path if you do not provide another mount there.

An anonymous volume is a Docker-managed volume that does not have a meaningful user-assigned name.

to run 
```shell
docker run -d --name volume_container \
	--mount type=volume,source=my_data,target=/app/data volume_test
```

### WORKDIR - Set the working directory
`WORKDIR` defines the working directory used by subsequent Dockerfile instructions.

It is similar to executing `cd` in a Linux terminal, but the selected directory also applies to later relevant instructions and becomes the image's default working directory.

Example:
```Dockerfile
WORKDIR /path
```

## Dockerfile Best Practices
1. Choose an appropiate base image
2. Give each container one main resposibilty
3. Combine related run instruction
4. Use docker build cache for faster image building
5. Use `COPY` instead of `ADD`
6. Use exec form for `CMD` and `ENTRYPOINT` combine them
7. Do not store secrets in your Dockerfile
8. Add Metadata
9. Use a `.dockerignore` file
10. Clean Up Temporary Files 
11. Run applications with appropriate privileges
12. setup an user so the container doesn't run as the root user
13. Do not use unnecessary background processes
14. Understand `EXPOSE` versus published ports
15. Use docker volumes
16. Use `HEALTHCHECK` when it adds useful information
17. Make your images reproducible and maintainable


# NGINX configuration

how to create a new certificate with openssl 
[How to Create a self-signed SSL certificate](https://linuxize.com/post/creating-a-self-signed-ssl-certificate/)

```bash
openssl req -x509 rsa:4096 -sha256 -noenc -keyout server.key -out server.crt -days 3650 \
-subj "/C=FR/ST=Paris/L=Paris/O=42paris/OU=Inception/CN=ehossian.42.fr"
```

The way nginx and its modules work is determined in the configuration file. By default, the configuration file is named `nginx.conf` and placed in the directory `/usr/local/nginx/conf`, `/etc/nginx`, or `/usr/local/etc/nginx`.

The first file that nginx reads when it starts is `/etc/nginx/nginx.conf`. This file is maintained by Nginx package maintainers and it is recommended that administrators avoid editing this file unless they also follow changes made by upstream.

It's advised to instead add customizations underneath of the `conf.d/` directory which is described below.

nginx config files are written in blocks and inside your code block every line has to end with an `;` semicolone
```conf
server {
	listen 443 ssl;	
}
```

RFTM: [Beginners guide nginx](https://nginx.org/en/docs/beginners_guide.html)

```conf
server {
	listen 443 ssl;
	listen [::]443 ssl;
	
	server_name ehossain.42.fr;
	
	ssl_certificate /path_to_certificate ;
	ssl_certificate_key /path_to_certificate_key;
	ssl_protocols TLSv1.3;
	
	root /var/www/html;
	index index.html index.php
}
```


# CGI (Common Gateway Interface) and FastCGI
CGI (Common Gateway Interface) and FastCGI are communication protocols that allow web servers to execute external programs and generate dynamic web content.  It is not a package or library, but an interface that bridges the gap between web servers and server-side applications.

CGI is the original standard protocol for running external application scripts via a web server.

### What is CGI
CGI is the original standard protocol for running external application scripts via a web server. 

- For every single HTTP request received the web server create a new independent os process.
- The process loads the script, initializes the environment, processes the request, sends the response back to the web server, and then immediately shuts down.
- The Problem: Creating and destroying a process for every request consumes massive CPU and memory overhead. This causes severe performance bottlenecks under high traffic.

### What is FastCGI
FastCGI is an upgraded, high-performance extension of CGI designed to fix those exact speed and scaling limitations. 

- Process Model: : Instead of killing a process after one request, FastCGI uses long-running, persistent background worker processes or a process pool.
- Lifecycle: : The web server passes multiple sequential requests to these already-running processes using sockets or TCP
- Benefit: It eliminates the massive startup and teardown delay of creating new operating system processes, making it vastly faster and more scalable. A common modern example of this is PHP-FPM (FastCGI Process Manager).

### What is PHP-FPM
PHP-FPM (FastCGI Process Manager) is an implementation of the FastCGI protocol specifically designed for PHP. Unlike CGI or FastCGI, php-fpm is an actual executable program that manages PHP processes on the server.

1. PHP-FPM runs as a separate daemon process on the server.
2. Nginx forwards PHP requests to php-fpm.
3. PHP-FPM executes the PHP application, processes the request, and sends the response back to nginx.

### Connecting PHP-FPM to NGINX
```conf
server {
    listen 80;
    server_name example.com;

    root /var/www/demo/public;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass 127.0.0.1:9000; # PHP-FPM listening address
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```

##### Key Points in the Configuration:

- `try_files` Directive: Ensures that nginx serves static files if they exist, or passes the request to application index.php for routing.
- `fastcgi_pass`  Specifies the address where php-fpm is listening.
- `fastcgi_param` Passes the script file name to php-fpm for execution.


# Proxy Servers Explained

[Proxy servers explained | Cloudflare](https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy/)
### What is a Proxy Server ?
A forward proxy, often called a proxy, proxy server, or web proxy, is a server that sits in front of a group of client machines. When those computers make requests to sites and services on the Internet, the proxy server intercepts those requests and then communicates with web servers on behalf of those clients, like a middleman.

### What is a reverse Proxy and how is it different ?
A reverse proxy is a server that sits in front of one or more web servers, intercepting requests from clients. This is different from a forward proxy, where the proxy sits in front of the clients. With a reverse proxy, when clients send requests to the origin server of a website, those requests are intercepted at the network edge by the reverse proxy server. The reverse proxy server will then send requests to and receive responses from the origin server.

The difference between a forward and reverse proxy is subtle but important. A simplified way to sum it up would be to say that a forward proxy sits in front of a client and ensures that no origin server ever communicates directly with that specific client. On the other hand, a reverse proxy sits in front of an origin server and ensures that no client ever communicates directly with that origin server.

# MariaDB

SQL(Structured Query Language): The universal programming language used to manage, query, and manipulate data within any relational database.

Mariadb: The actual software applications (database engines) that store the data and execute the SQL commands

MariaDB Server is a general purpose open source relational database management system. It’s one of the most popular database servers in the world, with notable users including `Wikipedia`, `WordPress.com` and `Google`.

install mariadb in dockerfile `apt-get install mariadb-server mariadb-client`. 

Where does MariaDB store its database ?
MariaDB doesn't store your databases inside the executable. It has a data directory, commonly: `/var/lib/mysql` .

An excelent guide to follow [Basic guide by mariadb](https://mariadb.com/docs/server/mariadb-quickstart-guides/basics-guide)

### [[MySQL]]

Some MySQL commands/statements to manupulate a db(data base)

launch `mariadb`. `SQL` statements are case insensetive but it is a widely accepted convention to write `SQL` keywords in `UPPERCASE` and identifiers in `lowercase` to make queries readable

Create a new db `CREATE DATABASE my_db;`  

the `;` semicolone is important it tells the end of cmd.

Delete a db `DROP DATABASE my_db;`

Work inside a db first `USE my_db;`

Create a new table inside a db `CREATE TABLE my_table;`

Delete a table `DROP TABLE my_table;`

Add, delete, or modify columns in an existing table 
`ALTER TABLE my_table ADD column_name datatype;`

The `INSERT INTO` statement is used to insert new records in a table.
```sql
INSERT INTO my_table
VALUES (value1, value2, value3);
```

The `SELECT` statement is used to select data from a database.
```sql
 SELECT CustomerName, City FROM Customers; 
```


# Wordpress + php-fpm

```bash
docker exec container_name wp db check --allow-root --path=/var/www/html
```


# How to configure a domain name

Use the `hostnamectl` command to permanently change your hostname to match your desired name

```
sudo hostnamectl set-hostname ://ehossain.42.fr

# verify the configuration
hostname -f
dnsdomainname
```


# Docker Network

Docker daemon automatically create three defaults network. You can check them with this cmd `docker network ls`. 
1. bridge(default)
2. host
3. none

Create a new network 
```shell
docker network create new_network
```

See all the network created by network
```
docker network ls
```

To remove one ot multiple networks
```
docker network rm name_network # remove one network
docker network prune # remove all unused network
```

Inspect network config
```
docker network inspect name_network
```

# Docker-compose



# Subject Requirements
### Must and Must not

- [x] Must use `docker compose`
- [x] Each `docker image` must have the same name as its corresponding service
- [x] Each service has to run in a dedicated container
- [x] You also have to write your own `Dockerfiles` one per service
- [x] The `Dockerfiles` must be called in your `docker-compose.yaml` by your `makefile`
- [x] It is forbidden to pull ready made `docker image` and using `docker hub`
- [x] Must use environment variables in a `.env` file.
- [x] Must user `docker secrets` to store confidential information.
- [x] Your `NGINX` container must be the only entrypoint into your infrastructure via the port `443` only, using the `TLSv1.3` protocol.

### Container Specefic Rules

- [x] A container that contains `NGINX` with `TLSv1.3`.
- [x] A container that contains `WordPress + php-fpm` (it must be installed and configured) without `NGINX`.
- [x] A container that contains `MariaDB` without `NGINX`
- [x] Containers must restart in case of a crash.

### Volume Specefic Rules

- [x] A volume that contains `WordPress`  database.
	- [x] In the `WordPress` database there must be two user, one of them being the administrator.
- [x] A second volume that contains `WordPress`  website files.
- [x] You must use Docker named volumes for these two persistent storages. Bind mounts are not allowed for these volumes.
- [x] Both named volumes must store their data inside `/home/ehossain/data` on the host machine.

### Network Specefic Rules

- [x] A `docker-network` that establishes the connection between containers.

### Bonus Part

- [ ] Set up redis cache for your WordPress website in order to properly manage the cache.
- [ ] Set up a FTP server container pointing to the volume of your WordPress website.
- [ ] Create a simple static website in the language of your choice except PHP (yes, PHP is excluded). For example, a showcase site or a site for presenting your resume.
- [ ] Set up Adminer.
- [ ] Set up a service of your choice that you think is useful. During the defense, yoy will have to justify your choice.

---

# Resouces

[Docker Curriculum | Docker Curriculum](https://docker-curriculum.com/) 
[Docker Crash Course #1 - What is Docker? - YouTube](https://www.youtube.com/watch?v=31ieHmcTUOk&list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7) 
[Optimize Your Deployment With Docker Containers - OpenClassrooms](https://openclassrooms.com/fr/courses/7905646-optimize-your-deployment-with-docker-containers) 
[Dockerfile reference | Docker Docs](https://docs.docker.com/reference/dockerfile)
[Writing a Dockerfile: Beginners to Advanced - DEV Community](https://dev.to/prodevopsguytech/writing-a-dockerfile-beginners-to-advanced-31ie) 
[Reference documentation | Docker Docs](https://docs.docker.com/reference/) 
[docker_cheatsheet.pdf](https://docs.docker.com/get-started/docker_cheatsheet.pdf) 
[Docker Best Practices: Choosing Between RUN, CMD, and ENTRYPOINT | Docker](https://www.docker.com/blog/docker-best-practices-choosing-between-run-cmd-and-entrypoint/) 
[Docker Run Command with Examples | Linuxize](https://linuxize.com/post/docker-run-command/) 
[How to Build Docker Images with Dockerfile | Linuxize](https://linuxize.com/post/how-to-build-docker-images-with-dockerfile/) 
[Docker Compose: Define and Run Multi-Container Apps | Linuxize](https://linuxize.com/post/docker-compose/) 
[How to Remove Docker Images, Containers, Volumes, and Networks | Linuxize](https://linuxize.com/post/how-to-remove-docker-images-containers-volumes-and-networks/) 
[Docker - Container for NGINX - GeeksforGeeks](https://www.geeksforgeeks.org/devops/docker-container-for-nginx/) 
[Using The NGINX Docker Image | Octopus blog](https://octopus.com/blog/using-nginx-docker-image) 
[How to Use Docker Volumes for Persistent Data](https://oneuptime.com/blog/post/2026-02-02-docker-volumes-persistent-data/view) 
[How to Run Nginx in Docker](https://oneuptime.com/blog/post/2026-01-25-nginx-docker/view)
[Storage | Docker Docs](https://docs.docker.com/engine/storage/) [Volumes | Docker Docs](https://docs.docker.com/engine/storage/volumes/) 
[Building best practices | Docker Docs](https://docs.docker.com/build/building/best-practices/) 
[Compose file reference | Docker Docs](https://docs.docker.com/reference/compose-file/) 
[Dockerfile reference | Docker Docs](https://docs.docker.com/reference/dockerfile/?utm_source=chatgpt.com) 
[Writing a Dockerfile | Docker Docs](https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/) 
[Networking overview | Docker Docs](https://docs.docker.com/engine/network/) 
[What Is Docker Networking? A Practical Guide](https://www.aquasec.com/cloud-native-academy/docker-container/docker-networking/) 
[Networking in Compose | Docker Docs](https://docs.docker.com/compose/how-tos/networking/) 
[Bridge network driver | Docker Docs](https://docs.docker.com/engine/network/drivers/bridge/) 
[Introduction to Docker Networking | Refine](https://refine.dev/blog/docker-networking/#bridge-docker0) 
[Manage sensitive data with Docker secrets | Docker Docs](https://docs.docker.com/engine/swarm/secrets/) 
[Understanding the Nginx Configuration File Structure and Configuration Contexts | DigitalOcean](https://www.digitalocean.com/community/tutorials/understanding-the-nginx-configuration-file-structure-and-configuration-contexts) 
[Beginner’s Guide](https://nginx.org/en/docs/beginners_guide.html) [Configuring HTTPS servers](https://nginx.org/en/docs/http/configuring_https_servers.html) 
[Configuring HTTPS/TLS on nginx: A Complete Guide for Securing Web Traffic](https://travishorn.com/configuring-httpstls-on-nginx-a-complete-guide-for-securing-web-traffic/)




 The irony of humanity digging gold out of the earth just to bury it away in a vault is profoundly moving. It shows how deeply we misunderstand true value and the art of living. What people chase as 'luxury' is often just a lazy substitute for a meaningful life. We are left with a constant, lingering feeling that something is missing—and what we are truly missing is our connection to nature. 
