###!/usr/bin/env bash
#set -e

PHP_VERSION=$1
cd `dirname $0`

echo "FROM ci/base:${PHP_VERSION}" >> Dockerfile.${PHP_VERSION}

#echo "RUN rm -f /var/www/html/index.html" >> Dockerfile.${PHP_VERSION}
##echo "ADD code /var/www/html" >> Dockerfile.${PHP_VERSION}
#echo "RUN cp /test/index.php /var/www/html/" >> Dockerfile.${PHP_VERSION}

docker build -t ci/base:${PHP_VERSION} -f ../${PHP_VERSION}/Dockerfile ../
docker build -t ci/test:${PHP_VERSION} -f Dockerfile.${PHP_VERSION} .

# run the container
CID=`docker run --rm -d -p 9876:80 ci/test:${PHP_VERSION}`
echo "Docker Container ID: $CID"
CONTAINER_IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${CID}`
echo "Docker Container IP: $CONTAINER_IP"

# wait for start of apache
sleep 15
#curl -vf http://localhost:9876/index.php
curl -vf http://0.0.0.0:9876/index.php

docker stop $CID
