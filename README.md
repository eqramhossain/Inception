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

#### What is a volume ?

#### What is a persistent storage docker ?

#### What is a docker-network ?

#### What is Docker secrets ?

#### What is a deamon ?

#### What is yml ?

#### What is PID 1 and the best practices for writing Dockerfiles ?

#### What is a domaine name ?

#### How to set up a domaine name in a vm localhost and redirect to the IP address ?

#### What is environment variables and how to setup one in an .env file ?

#### What is Docker secrets to store any confidential informatin ?

#### What is TLS and how to encript NGNIX with TLSv1.3 protocol via port 443 ?


### Bonus:
#### What is a redis cache ? How to set up one for a WordPress website ?

#### What is a FTP Server ?

#### How to set up a FTP server container pointing to the volume of your WordPress website ?

#### What is a static website ?

#### What is and Adminer ?

#### How to setup an Adminer ?

#### What is the latest tag and why is it prohibitated ?


---

add user to `docker gourp` so we can use it without calling `sudo` everytime. `docker` need root permission so be cautious.


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


# Dockerfile

Dockerfiles supports following keywords.

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

ADD

## Dockerfile Best Practices


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

| Website                                                                                 |
| --------------------------------------------------------------------------------------- |
| https://www.docker.com/101-tutorial/<br>                                                |
| https://docker-curriculum.com/<br>                                                      |
| https://www.youtube.com/watch?v=DQdB7wFEygo&t=48s<br>                                   |
| https://www.youtube.com/watch?v=gAkwW2tuIqE<br>                                         |
| https://www.youtube.com/watch?v=Ud7Npgi6x8E&t=290s<br>                                  |
| https://www.youtube.com/watch?v=31ieHmcTUOk&list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7<br> |
| https://www.youtube.com/watch?v=eGz9DS-aIeY                                             |

