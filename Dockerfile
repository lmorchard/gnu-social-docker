FROM php:5.6-apache

WORKDIR /var/www/html

RUN apt-get update \
    && apt-get install -y \
        zlib1g-dev libpng12-dev libgmpxx4ldbl libgmp-dev re2c libmhash-dev \
        libmcrypt-dev libicu-dev file locales-all \
        --no-install-recommends

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
RUN docker-php-ext-configure gmp --with-gmp=/usr/include/x86_64-linux-gnu

RUN docker-php-ext-install gd gmp intl json mcrypt mbstring mysqli opcache exif gettext

RUN rm -rf /var/lib/apt/lists/*

COPY ./gnu-social /var/www/html
COPY startup.sh /var/www/html/startup.sh
RUN chmod a+x startup.sh

RUN a2enmod rewrite
RUN mv htaccess.sample .htaccess

RUN mkdir -p /var/www/html/avatar && \
    mkdir -p /var/www/html/file && \
    chgrp -R www-data /var/www/html/ && \
    chmod -R g+w /var/www/html/

EXPOSE 80
CMD ["./startup.sh"]
