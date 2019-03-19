
# Apache/PHP Docker Images und Container


- *derzeit verfügbare PHP Versionen*: **5.6**, **7.7**, **7.1**, **7.2**, **7.3**


---


Repository auschecken und direkt gewünschtes Image bauen lassen...


## Apache/PHP Image bauen (im Repo-root ausführen)

```bash
docker build -t <image-name>:<image-version> -f <php-version>/Dockerfile ./
```

Bsp:
```bash
docker build -t httpd-php7.2:latest -f 7.2/Dockerfile ./
```


---


## Container mit Website starten

```bash
docker run -d -v </absoluter/pfad/zum/docroot>:/var/www/html -p <target-port>:80 --name <container-name> <image-name>:<image-version>
```

Bsp:
```bash
docker run -d -v /Users/icke/Websites/dein-projekt:/var/www/html -p 8080:80 --name "dein-projekt" httpd-php7.2:latest
```
Die Website ist dann unter `http://localhost:8080` aufrufbar, ggf. auch über die IP 127.0.0.1 oder auch die Docker-eigene Container-IP.


---


### Shell-Commando im Container ausführen

```bash
docker exec -t -i <container-name> <shell-command>
```

Bsp: Shell-Zugang zum Container
```bash
docker exec -t -i "dein-projekt" /bin/bash
```


---


### Log-Dateien im Container ansehen

```bash
docker logs <container-name>
```

Bsp:
```bash
docker logs "dein-projekt"
```


---


## Container mit mySQL starten

```bash
docker run -d -e MYSQL_ROOT_PASSWORD=<password> -p <target-port>:3306 --name <container-name> mysql:<mysql-version>
```

Bsp:
```bash
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass1234 --name "meine-lokalen-db" mysql:5.6
```
Zu diesem Server kann man sich dann mittels `mysql://localhost:3306` verbinden, ggf. auch über die IP 127.0.0.1 oder auch die Docker-eigene Container-IP.


### Root-User ohne Passwort

Um kein Passwort für den Root-User zu setzen, den Parameter `-e MYSQL_ROOT_PASSWORD=<password>` einfach 'leer' lassen:
```bash
docker run -d -p 3380:3306 -e MYSQL_ROOT_PASSWORD= --name "dein-projekt-db" mysql:5.6
```


---


## CI Konfiguration


Für's Deployment (Push zu 'hub.docker.com') ist ein Docker build-/Zugangs-Token erforderlich


---


## Links, weitere Infos


- Docker intro, install/download: https://www.docker.com/get-started
- Docker docs: https://docs.docker.com/get-started/
- Docker-Hub (global) image repository: https://hub.docker.com/

Dieses Repository ist abgeleitet von und ergänzt https://github.com/mobingidocker/ubuntu-apache2-php7 .
