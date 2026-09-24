FROM debian:bookworm-slim

WORKDIR /usr/bin/

LABEL image.maintainer="ehossain" \
	image.maintainer_email="ehossain@student.42.fr" \
	image.title="Inception NGINX"

RUN apt-get update && apt-get install --no-install-recommends -y \
	curl \
	vim \
	openssl \
	nginx \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 443

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

COPY ./tools/script.sh .
RUN chmod +x /usr/bin/script.sh

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
	CMD curl -fsS https://ehossain.42.fr/ >> /dev/null || exit 1

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/usr/bin/script.sh"]

CMD ["nginx", "-g", "daemon off;"]
