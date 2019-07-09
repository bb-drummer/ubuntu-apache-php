FROM ubuntu:16.04

LABEL maintainer="Björn Bartels <coding@bjoernbartels.earth>"

RUN apt-get update && apt-get install -y --no-install-recommends \
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

RUN apt-get update && apt-get install -y wget curl vim nano

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-seup.php');"

COPY script/run.sh /run.sh
RUN chmod 755 /run.sh

COPY conf/config /config
RUN rm -f /var/www/html/index.htm*
COPY test/index.php /var/www/html/


EXPOSE 80
CMD ["/run.sh"]
