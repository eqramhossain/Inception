FROM debian:bookworm-slim


RUN apt-get update && apt-get install --no-install-recommends -y vim wordpress php-fmp && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# mysql-server
# php5-fpm php5-mysql php5-gd php5-cli

EXPOSE 9000

ENTRYPOINT ["./script.sh"]

CMD []
