FROM debian:bookworm-slim

LABEL image.maintainer="ehossain" \
	image.maintainer.email="ehossain@student.42.fr"

WORKDIR /usr/bin/

RUN apt-get update && apt-get install --no-install-recommends -y ca-certificates vim curl nginx openssl && apt-get autoremove && rm -rf /var/lib/apt/lists/*

COPY ./tools/script.sh .
RUN chmod +x script.sh

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

EXPOSE 443

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/usr/bin/script.sh"]

CMD ["nginx", "-g", "daemon off;"]
