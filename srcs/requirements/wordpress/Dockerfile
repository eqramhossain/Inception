FROM debian:bookworm-slim

LABEL image.maintainer="ehossain" \
	image.maintainer.email="ehossain@student.42.fr"

RUN apt-get update && apt-get install --no-install-recommends -y \
	vim \
	wordpress \
	php-curl \
	php-gd \
	php-mbstring \
	php-xml \
	php-zip \
	php-fpm \
	php-mysql \
	php-cli \
	curl \
	ca-certificates \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/bin/

COPY ./tools/script.sh .
RUN chmod +x script.sh 

STOPSIGNAL SIGQUIT

EXPOSE 9000

ENTRYPOINT ["/usr/bin/script.sh"]

# CMD ["wait"]
