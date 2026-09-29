FROM debian:bookworm-slim

RUN apt-get update && apt-get install --no-install-recommends -y vim mariadb-server mariadb-client && apt-get autoremove && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/bin/

COPY ./tools/script.sh .
RUN chmod +x script.sh

EXPOSE 3306

ENTRYPOINT ["./script.sh"]

CMD ["mariadb"]
