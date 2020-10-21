FROM ubuntu:20.04

LABEL maintainer="Björn Bartels <coding@bjoernbartels.earth>"

ENV TZ="Europe/Berlin"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
		apache2 \
		software-properties-common \
		supervisor \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y --no-install-recommends \
		libapache2-mod-php7.3 \
		php7.3 \
		php7.3-bcmath \
		php7.3-cli \
		php7.3-ctype \
		php7.3-curl \
		php7.3-dev \
		php7.3-gd \
		php7.3-imap \
		php7.3-intl \
		php7.3-mbstring \
    php7.1-mcrypt \
		php7.3-mysql \
		php7.3-mysqli \
		php7.3-pgsql \
		php7.3-pspell \
		php7.3-xml \
		php7.3-xmlrpc \
		php-apcu \
		php-memcached \
		php-pear \
		php-redis \
		php-zip \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

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
