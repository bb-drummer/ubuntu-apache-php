FROM ubuntu:20.04

LABEL maintainer="Björn Bartels <coding@bjoernbartels.earth>"

ENV TZ="Europe/Berlin"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends \
		apache2 \
		software-properties-common \
		supervisor \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y --no-install-recommends \
		libapache2-mod-php5.6 \
		php5.6 \
		php5.6-bcmath \
		php5.6-cli \
		php5.6-ctype \
		php5.6-curl \
		php5.6-dev \
		php5.6-gd \
		php5.6-imap \
		php5.6-intl \
		php5.6-mbstring \
    php5.6-mcrypt \
		php5.6-mysql \
		php5.6-mysqli \
		php5.6-pgsql \
		php5.6-pspell \
		php5.6-xml \
		php5.6-xmlrpc \
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
