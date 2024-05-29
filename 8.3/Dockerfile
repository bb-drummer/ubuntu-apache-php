FROM ubuntu:20.04

LABEL maintainer="Björn Bartels <coding@bjoernbartels.earth>"

ENV TZ="Europe/Berlin"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends \
		apache2 \
		software-properties-common \
		supervisor \
        build-essential \
		wget \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y --no-install-recommends \
		libapache2-mod-php8.3 \
		php8.3 \
		php8.3-bcmath \
		php8.3-cli \
		php8.3-ctype \
		php8.3-curl \
		php8.3-dev \
		php8.3-gd \
		php8.3-imap \
		php8.3-intl \
		php8.3-mbstring \
		php8.3-mysql \
		php8.3-pgsql \
		php8.3-pspell \
		php-xml \
		php8.3-xml \
		php8.3-xmlrpc \
		php8.3-apcu \
		php-pear \
		php8.3-zip \
		php-memcached \
    libmcrypt-dev \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

RUN wget http://pear.php.net/go-pear.phar \
  && php go-pear.phar

RUN pecl channel-update pecl.php.net
RUN pecl install -o -f mcrypt-1.0.5 && \
    echo "extension=mcrypt.so" > /etc/php/8.2/apache2/conf.d/30-mcrypt.ini

RUN pecl install redis-5.3.7 \
    echo "extension=redis.so" > /etc/php/8.2/apache2/conf.d/30-redis.ini

RUN pecl install xdebug-3.3.2 \
    echo "extension=xdebug.so" > /etc/php/8.2/apache2/conf.d/30-xdebug.ini

#RUN apt-get install -y libmemcached zlib1g \
#    && pecl install memcached-3.2.0 \
#    echo "extension=memcached.so" > /etc/php/8.0/apache2/conf.d/30-memcached.ini




RUN a2enmod rewrite
COPY conf/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt-get update && apt-get install -y wget curl vim nano && \
		apt-get clean && rm -rf /var/lib/apt/lists/*

COPY script/install-composer.sh /install-composer.sh
RUN chmod 755 /install-composer.sh && /install-composer.sh

COPY script/run.sh /run.sh
RUN chmod 755 /run.sh

COPY conf/config /config
RUN rm -f /var/www/html/index.htm*
COPY test/index.php /var/www/html/


EXPOSE 80
CMD ["/run.sh"]
