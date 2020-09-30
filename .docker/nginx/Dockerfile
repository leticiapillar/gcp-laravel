FROM nginx:1.18.0-alpine

RUN apk add --no-cache openssl

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN rm /etc/nginx/conf.d/default.conf
# COPY ./nginx.conf /etc/nginx/conf.d
COPY ./nginx.tmpl /etc/nginx/conf.d

# Se a configuração for apenas pelo arquivo Dockerfile, e não usar o arquivo docker-compose.yaml
# ENTRYPOINT [ "dockerize", "-template", "/etc/nginx/conf.d/nginx.tmpl:/etc/nginx/conf.d/nginx.conf"]
# CMD ["nginx", "-g", "daemon off;"]
