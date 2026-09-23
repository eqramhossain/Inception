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

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
	CMD curl -fsS http://localhost/ >> /dev/null || exit 1

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
