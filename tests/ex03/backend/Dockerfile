# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ehossain <ehossain@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/09/18 16:20:37 by ehossain          #+#    #+#              #
#    Updated: 2026/09/19 19:41:54 by ehossain         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bookworm-slim

RUN apt-get update
RUN apt-get install -y mariadb-server vim
RUN rm -rf /var/lib/apt/lists

EXPOSE 3306

CMD ["mariadb", "--user=mysql"]
