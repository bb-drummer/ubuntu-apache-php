###!/usr/bin/env bash
set -e

PHP_VERSION=$1
cd `dirname $0`

echo "FROM ci/base:${PHP_VERSION}" >> Dockerfile.${PHP_VERSION}
echo "RUN rm -f /var/www/html/index.html" >> Dockerfile.${PHP_VERSION}
##echo "ADD code /var/www/html" >> Dockerfile.${PHP_VERSION}
echo "RUN cp /test/index.php /var/www/html/" >> Dockerfile.${PHP_VERSION}
echo "RUN service apache2 restart" >> Dockerfile.${PHP_VERSION}
echo "RUN cat /var/log/apache2/error.log" >> Dockerfile.${PHP_VERSION}
echo "RUN apache2ctl -S" >> Dockerfile.${PHP_VERSION}
echo "RUN ifconfig" >> Dockerfile.${PHP_VERSION}

docker build -t ci/base:${PHP_VERSION} -f ../${PHP_VERSION}/Dockerfile ../
docker build -t ci/test:${PHP_VERSION} -f Dockerfile.${PHP_VERSION} .

CID=`docker run -d -p 80:80 ci/test:${PHP_VERSION}`

echo "Docker Container ID: $CID"
# wait for start of apache
sleep 60
curl -vf localhost
#curl -vf http://172.18.0.2

docker stop $CID
