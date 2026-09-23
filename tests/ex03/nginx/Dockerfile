FROM debian:bookworm-slim

MAINTAINER "ehossain <ehossain.student.42.fr>"

LABEL image.title="Inception NGINX"

WORKDIR /var/www/html/

RUN apt-get update && \
	apt-get install --no-install-recommends -y nginx vim openssl \
	rm -rf /var/lib/apt/lists

COPY ./files/index.html .

EXPOSE 80

SHELL ["/bin/bash", "-c"]

RUN useradd -m nginx_user

USER nginx_user

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
	CMD curl -fsS http://localhost/ >> /dev/null || exit 1

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
