# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ehossain <ehossain@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/09/18 16:20:37 by ehossain          #+#    #+#              #
#    Updated: 2026/09/18 16:51:12 by ehossain         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bookworm

RUN apt-get update
RUN apt-get install -y mariadb-server vim
RUN rm -rf /var/lib/apt/lists

RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

CMD ["mariadb", "--user=mysql"]
