#!/bin/bash
service wdcp start && \
service httpd start && \
service nginxd start && \
service mysqld start && \
service pureftpd start && \
service memcached start && \
tail -f /dev/null