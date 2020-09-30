FROM php:7.3-fpm-alpine

RUN apk add --no-cache openssl bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN apk add --no-cache shadow

WORKDIR /var/www
RUN rm -rf /var/www/html 

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Isto faz sentido apenas se criarmos um build da imagem com todos os arquivos de configuração do laravel 
# fazendo uma copia do projeto e gerando um build da imagem para uso posterior
# arquivos: .env, package.json, compose.json, diretorio vendor
# Faz uma copia do projeto laravel para dentro da imagem do container
# COPY . /var/www
# Executa a configuração do laravel, em um volume compartilhado de faltar os arquivos de configuração do laravel, por exemplo o diretorio vendo, isso não funciona 
# RUN composer install && \
#     cp .env.example .env && \
#     php artisan key:generate && \
#     php artisan config:cache 


RUN chown -R www-data:www-data /var/www
RUN ln -s public html

RUN usermod -u 1000 www-data
USER www-data

EXPOSE 9000
ENTRYPOINT ["php-fpm"]