#!/bin/bash

# Create docker network
docker network create --driver bridge wolfetti-iredmail-network-dev

# Create mysql container
docker run -d --name wolfetti-iredmail-mysql-dev \
  -v wolfetti-iredmail-mysql-dev_data:/var/lib/mysql \
  --network="wolfetti-iredmail-network-dev" \
  -p 33006:3306 \
  -e MYSQL_ROOT_PASSWORD="root" \
  -e MYSQL_ROOT_HOST="%" \
  mysql/mysql-server:5.7

# Installing iredmail databases and users
echo "Waiting for MySQL server up and running...."
while true; do
  sleep 2
  ID=$(docker ps -qf "name=wolfetti-iredmail-mysql-dev")
  if [[ "" != "$ID" ]]; then
    while [[ "$(docker exec -i $ID mysqladmin -uhealthchecker -phealthcheckpass ping 2> /dev/null)" != "mysqld is alive" ]]; do
      sleep 1
    done
    for file in $(/bin/ls ./mysql); do
      echo "Installing $file..."
      cat ./develop/mysql/$file | docker exec -i $ID \
        mysql -uroot -proot \
        2>&1 | grep -v "\[Warning\]"
      sleep 2
    done
    break;
  fi
done
echo -e "\nEnvironment setup done!\n"
