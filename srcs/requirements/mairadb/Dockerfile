FROM debian:bookworm-slim

LABEL image.maintainer="ehossain" \
	image.maintainer.email="ehossain@student.42.fr"

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

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/usr/bin/script.sh"]

CMD ["mariadbd", "--user=mysql"]
