#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini
if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
    echo "=> Create MySQL Admin User"
    /create_mysql_admin_user.sh
    echo "=> Done!"
    echo "=> Import MySQL Testlink Data"
    /import_mysql_testlink_data.sh $MYSQL_PASS
    echo "=> Done!"
    echo "=> Set MySQL User password into testlink"
    sed -i "s/testlink_pass/$MYSQL_PASS/g" /app/testlink/config_db.inc.php
    echo "=> Done!"
    echo "=> Clean after install"
    /clean.sh
    echo "=> Done!"
else
    echo "=> Using an existing volume of MySQL"
fi

exec supervisord -n
