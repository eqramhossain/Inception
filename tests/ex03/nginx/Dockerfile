FROM debian:bookworm-slim

WORKDIR /var/www/html/

RUN apt-get update && apt-get install --no-install-recommend -y nginx vim
RUN rm -rf /var/lib/apt/lists

COPY ./files/index.html .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
