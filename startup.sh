#!/bin/bash

if [ ! -f config.php ]; then
  sleep 10; # HACK: Wait for the database to come online
  php scripts/install_cli.php \
    --server=$SITE_SERVER --path=$SITE_PATH --sitename=$SITE_NAME --fancy=yes \
    --dbtype=mysql --host=$DB_PORT_3306_TCP_ADDR --database=$DB_ENV_MYSQL_DATABASE \
    --username=$DB_ENV_MYSQL_USER --password=$DB_ENV_MYSQL_PASSWORD \
    --admin-nick=$ADMIN_NICK --admin-pass=$ADMIN_PASS \
    --admin-email=$ADMIN_EMAIL --site-profile=$SITE_PROFILE
fi

/usr/local/bin/apache2-foreground
