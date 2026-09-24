# base image for container
FROM debian:bookworm-slim

# working directory in the container
WORKDIR /usr/bin/

# some metadata
LABEL image.maintainer="ehossain" \
	image.maintainer_email="ehossain@student.42.fr" \
	image.title="Inception NGINX"

# install all the dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	curl \
	vim \
	openssl \
	nginx \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

# the port for networking
EXPOSE 443

# copy the our custom nginx config file into the container
COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

# copy the script to run at the start of the container
COPY ./tools/script.sh .
RUN chmod +x /usr/bin/script.sh

# Nginx uses SIGQUIT for graceful shutdown. When Nginx receives SIGQUIT, 
# it finishes serving all in-progress requests before exiting.
# SIGTERM causes Nginx to shut down immediately.
STOPSIGNAL SIGQUIT

HEALTHCHECK --interval=30s --timeout=3s \
	CMD curl -fsSk https://localhost:443 || exit 1

ENTRYPOINT ["/usr/bin/script.sh"]

# argument to the shell script above
CMD ["nginx", "-g", "daemon off;"]
