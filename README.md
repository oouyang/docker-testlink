BUILD

docker build -t adeo/testlink .

RUN

docker run -d -p 80:80 -p 3306:3306 --name testlink -e MYSQL_PASS="admin" adeo/testlink

DEBUG

docker run -t -i -p 80:80 -p 3306:3306 -e MYSQL_PASS="admin" adeo/testlink /bin/bash
