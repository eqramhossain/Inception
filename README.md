This project has been created as part of the 42 curriculum by ehossain


# Inception

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



### Bonus:
#### What is a redis cache ? How to set up one for a WordPress website ?

#### What is a FTP Server ?

#### How to set up a FTP server container pointing to the volume of your WordPress website ?

#### What is a static website ?

#### What is and Adminer ?

#### How to setup an Adminer ?

#### What is the latest tag and why is it prohibitated ?


---

add user to `docker gourp` so we can use it without calling `sudo` everytime. `docker` need root permission any user added to `docker group` will have `root` privilege so be cautious.

# Docker Commands

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
`docker update --restart unlesll-stopped --name docker_container_id/name`

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

`MAINTAINER` was traditionally used to identify the person or organization maintaining a Docker image.

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
6. Use exec form for CMD and ENTRYPOINT ? 
7. Do not store secrets in your Dockerfile
8. Add Metadata
9. Use a .dockerignore file
10. Clean Up Temporary Files 
11. Run applications with appropriate privileges
12. setup an user so the container doesn't run as the root user
13. Do not use unnecessary background processes
14. Understand `EXPOSE` versus published ports
15. Use docker volumes
16. Use HEALTHCHECK when it adds useful information
17. Make your images reproducible and maintainable

# Docker Network

Docker daemon automatically create three defaults network. You can check them with this cmd `docker network ls`. 
1. bridge(default)
2. host
3. none







# Docker-compose


--- 

### Must and Must not

- [ ] Must use `docker compose`
- [ ] Each `docker image` must have the same name as its corresponding service
- [ ] Each service has to run in a dedicated container
- [ ] You also have to write your own `Dockerfiles` one per service
- [ ] The `Dockerfiles` must be called in your `docker-compose.yaml` by your `makefile`
- [ ] It is forbidden to pull ready made `docker image` and using `docker hub`
- [ ] Must use environment variables in a `.env` file.
- [ ] Must user `docker secrets` to store confidential information.
- [ ] Your `NGINX` container must be the only entrypoint into your infrastructure via the port `443` only, using the `TLSv1.3` protocol.

### Container Specefic Rules

- [ ] A container that contains `NGINX` with `TLSv1.3`.
- [ ] A container that contains `WordPress + php-fpm` (it must be installed and configured) without `NGINX`.
- [ ] A container that contains `MariaDB` without `NGINX`
- [ ] Containers must restart in case of a crash.

### Volume Specefic Rules

- [ ] A volume that contains `WordPress`  database.
	- [ ] In the `WordPress` database there must be two user, one of them being the administrator.
- [ ] A second volume that contains `WordPress`  website files.
- [ ] You must use Docker named volumes for these two persistent storages. Bind mounts are not allowed for these volumes.
- [ ] Both named volumes must store their data inside `/home/ehossain/data` on the host machine.

### Network Specefic Rules

- [ ] A `docker-network` that establishes the connection between containers.

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

