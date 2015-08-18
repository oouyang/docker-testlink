FROM quay.io/oouyang/lamp
MAINTAINER Equipe Webtop <webtop@webadeo.net>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get -y install php5-gd

RUN rm -fr /app && mkdir -p /app
ADD testlink.sh /testlink.sh
ADD clean.sh /clean.sh
ADD import_mysql_testlink_data.sh /import_mysql_testlink_data.sh
RUN chmod 755 /testlink.sh /clean.sh /import_mysql_testlink_data.sh

COPY . /app
WORKDIR /app
RUN tar -zxvf testlink-1.9.11.tar.gz && rm -f testlink-1.9.11.tar.gz
RUN mv testlink-1.9.11 testlink && rm -fr testlink-1.9.11
RUN mkdir -p /var/testlink/logs
RUN mkdir -p /var/testlink/upload_area
RUN chmod 777 /var/testlink/logs /var/testlink/upload_area /var/lib/php5 testlink/gui/templates_c
RUN cp config_db.inc.php testlink/

EXPOSE 80 3306
CMD ["/testlink.sh"]
