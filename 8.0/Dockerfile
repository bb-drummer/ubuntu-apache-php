FROM ubuntu:20.04

LABEL maintainer="Björn Bartels <coding@bjoernbartels.earth>"

ENV TZ="Europe/Berlin"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends \
		apache2 \
		software-properties-common \
		supervisor \
        build-essential \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y --no-install-recommends \
		libapache2-mod-php8.0 \
		php8.0 \
		php8.0-bcmath \
		php8.0-cli \
		php8.0-ctype \
		php8.0-curl \
		php8.0-dev \
		php8.0-gd \
		php8.0-imap \
		php8.0-intl \
		php8.0-mbstring \
		php8.0-mysql \
		php8.0-pgsql \
		php8.0-pspell \
		php8.0-xml \
		php8.0-xmlrpc \
		php8.0-apcu \
		php-pear \
		php8.0-zip \
		php-pear \
		php8-dev \
		php-memcached \
    libmcrypt-dev \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

#RUN pecl channel-update pecl.php.net
RUN pecl install -o -f mcrypt-1.0.5 && \
    echo "extension=mcrypt.so" > /etc/php/8.0/apache2/conf.d/30-mcrypt.ini

RUN pecl install redis \
    echo "extension=redis.so" > /etc/php/8.0/apache2/conf.d/30-redis.ini

RUN pecl install xdebug-3.1.5 \
    echo "extension=xdebug.so" > /etc/php/8.0/apache2/conf.d/30-xdebug.ini

#RUN apt-get install -y libmemcached zlib1g \
#    && pecl install memcached \
#    echo "extension=memcached.so" > /etc/php/8.0/apache2/conf.d/30-memcached.ini




RUN a2enmod rewrite
COPY conf/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt-get update && apt-get install -y wget curl vim nano

COPY script/install-composer.sh /install-composer.sh
RUN chmod 755 /install-composer.sh && /install-composer.sh

COPY script/run.sh /run.sh
RUN chmod 755 /run.sh

COPY conf/config /config
RUN rm -f /var/www/html/index.htm*
COPY test/index.php /var/www/html/


EXPOSE 80
CMD ["/run.sh"]
