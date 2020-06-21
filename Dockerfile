FROM php:7.3-apache

RUN apt-get update
RUN apt-get install -y libicu-dev xz-utils git zlib1g-dev python libgmp-dev gettext libzip-dev jq unzip
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install intl
RUN docker-php-ext-install zip
RUN docker-php-ext-install gmp
RUN docker-php-ext-install gettext
RUN a2enmod rewrite

RUN curl -o \
	/tmp/alltube.zip -L \
    $(curl -s https://api.github.com/repos/Rudloff/alltube/releases/latest | jq -r '.assets[0].browser_download_url') && \
    unzip /tmp/alltube.zip -d /var/www/html/ && \
    cp /var/www/html/resources/php.ini /usr/local/etc/php/ && \
    chown -fR www-data: /var/www/html && \
    apt-get clean && \
    rm -rf /tmp/*

ENV CONVERT=1
