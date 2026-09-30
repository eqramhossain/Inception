FROM debian:bookworm-slim

RUN apt-get update && apt-get install --no-install-recommends -y \
	vim \
	mariadb-client \
	mariadb-server \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/bin/

COPY ./conf/my.cnf /etc/mysql/

COPY ./tools/script.sh .
RUN chmod +x script.sh 

EXPOSE 3306

ENTRYPOINT ["/usr/bin/script.sh"]

CMD ["mariadbd", "--user=mysql"]
