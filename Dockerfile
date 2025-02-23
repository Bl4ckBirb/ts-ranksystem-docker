FROM php:8.2-apache
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    libssh2-1-dev \
    libssh2-1
RUN pecl install ssh2 && docker-php-ext-enable ssh2
RUN docker-php-ext-install mysqli pdo pdo_mysql zip
ENV APACHE_PORT 80
RUN sed -ri -e 's!80!${APACHE_PORT}!g' /etc/apache2/ports.conf
ENV APACHE_PORT_SSL 443
RUN sed -ri -e 's!443!${APACHE_PORT_SSL}!g' /etc/apache2/ports.conf
COPY php.ini /usr/local/etc/php/php.ini
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]