FROM debian:bookworm-slim

LABEL image.maintainer="ehossain" \
	image.maintainer_email="ehossain@student.42.fr" \
	image.title="Inception NGINX"

RUN apt-get update && apt-get install --no-install-recommends -y \
	curl \
	vim \
	openssl \
	nginx \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 80

COPY ./tools/script.sh /bin/
RUN chmod +x /bin/script.sh

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
	CMD curl -fsS http://localhost/ >> /dev/null || exit 1

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/bin/script.sh"]

CMD ["nginx", "-g", "daemon off;"]
