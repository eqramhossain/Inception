FROM debian:bookworm-slim

LABEL image.maintainer="ehossain"\
image.maintainer.email="ehossain@student.42.fr"\
image.name="Inception"

EXPOSE 443

RUN apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	vim \
	curl \
	nginx \
	openssl \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/bin/

COPY ./tools/script.sh .
RUN chmod +x /usr/bin/script.sh

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

STOPSIGNAL SIGQUIT

# -f fail -s silent -S show-error -k insecure
HEALTHCHECK --interval=30s --timeout=3s \
	CMD curl -fsSk https://localhost:443 > /dev/null || exit 1

ENTRYPOINT ["./script.sh"]

CMD ["nginx", "-g", "daemon off;"]
