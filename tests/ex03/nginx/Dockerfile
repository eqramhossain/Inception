FROM debian:bookworm

RUN apt-get update && apt-get install --no-install-recommend -y nginx vim
RUN rm -rf /var/lib/apt/lists

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
