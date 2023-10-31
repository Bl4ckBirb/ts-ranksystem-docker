FROM php:8.2-apache
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    libssh2-1-dev \
    libssh2-1
RUN pecl install ssh2 && docker-php-ext-enable ssh2
RUN docker-php-ext-install mysqli pdo pdo_mysql zip
COPY php.ini /usr/local/etc/php/php.ini