#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

echo "CREATE DATABASE"
mysql -uadmin -padmin -e "CREATE DATABASE testlink"

echo "IMPORT DATABASE SCHEMA"
mysql -uadmin -padmin -Dtestlink < /app/testlink/install/sql/mysql/testlink_create_tables.sql

echo "INSERT DATA"
mysql -uadmin -padmin -Dtestlink < /app/testlink/install/sql/mysql/testlink_create_default_data.sql


mysqladmin -uroot shutdown
