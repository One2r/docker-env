#!/bin/bash
/usr/local/openresty/bin/openresty
/usr/local/php/sbin/php-fpm
/usr/local/redis/bin/redis-server /usr/local/redis-3.2.11/etc/redis.conf
#/etc/init.d/mysqld start