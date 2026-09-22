FROM debian:bookworm-slim

WORKDIR /var/www/html/

RUN apt-get update && apt-get install --no-install-recommends -y nginx vim openssl
RUN rm -rf /var/lib/apt/lists

COPY ./files/index.html .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
