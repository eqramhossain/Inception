FROM debian:bookworm-slim


LABEL image.maintainer="ehossain" \
	image.maintainer_email="ehossain@student.42.fr" \
	image.title="Inception NGINX"

WORKDIR /var/www/html/

RUN apt-get update && apt-get install --no-install-recommends -y \
	curl \
	vim \
	openssl \
	nginx \
	&& rm -rf /var/lib/apt/lists/*

COPY ./files/index.html .

EXPOSE 80

SHELL ["/bin/bash", "-c"]

# Debian's NGINX package automatically creates a user named 'www-data' 
# and creates all runtime directories under its ownership. 
# update the permissions so 'nginx_user' can access them.
# first part user_owner and second part group_owner
RUN useradd -m nginx_user \
	&& chown -R nginx_user:nginx_user /var/www/html \
	&& chown -R nginx_user:nginx_user /var/lib/nginx \
	&& chown -R nginx_user:nginx_user /var/log/nginx \
	&& chown -R nginx_user:nginx_user /etc/nginx

USER nginx_user

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
	CMD curl -fsS http://localhost/ >> /dev/null || exit 1

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
