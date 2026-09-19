FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends nginx vim 
RUN rm -rf /var/lib/apt/lists

COPY ./src/index.html /var/www/html/

EXPOSE 80

CMD ["nginx", "-g" , "daemon off;"]
