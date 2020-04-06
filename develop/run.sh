#!/bin/bash

if [[ "$(docker ps -a | grep 'wolfetti-iredmail-dev')" != "" ]]; then
  docker stop wolfetti-iredmail-dev
  docker rm wolfetti-iredmail-dev
fi

docker run -d --name wolfetti-iredmail-dev \
  --network="wolfetti-iredmail-network-dev" \
  -v wolfetti-iredmail-dev_data:/var/vmail \
  -e HOSTNAME="mail" \
  -e DOMAIN="wolfetti.example" \
  -e MYSQL_HOST="wolfetti-iredmail-mysql-dev" \
  -e AMAVISD_DB_PASSWD="amavisd" \
  -e IREDADMIN_DB_PASSWD="iredadmin" \
  -e IREDAPD_DB_PASSWD="iredapd" \
  -e ROUNDCUBE_DB_PASSWD="roundcube" \
  -e VMAIL_DB_PASSWD="vmail" \
  -e VMAIL_ADMIN_DB_PASSWD="vmailadmin" \
  -p 33080:80 \
  -p 33443:443 \
  -p 33025:25 \
  -p 33587:587 \
  -p 33110:110 \
  -p 33143:143 \
  -p 33993:993 \
  -p 33995:995 \
  wolfetti/iredmail
