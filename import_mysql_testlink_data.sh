#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

ADMIN_PASS=$1

mysql -uadmin -p$ADMIN_PASS -e "CREATE DATABASE testlink"

mysql -uadmin -p$ADMIN_PASS -Dtestlink < /app/testlink/install/sql/mysql/testlink_create_tables.sql

mysql -uadmin -p$ADMIN_PASS -Dtestlink < /app/testlink/install/sql/mysql/testlink_create_default_data.sql

mysqladmin -uroot shutdown
