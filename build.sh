#!/bin/bash
function error {
  if [ $1 -ne 0 ]; then
    echo -e "\n\e[31mERROR: $2\e[0m";
    docker-compose down
    exit 1
  fi;
}

docker-compose down
site_dir="./data/site"

echo "* generate db passwords"
root_pass=`date +%s | sha256sum | base64 | head -c 32 ; echo` #root mysql pass
db_pass=`date +%s | sha256sum | base64 | head -c 32 ; echo` #wordpress db pass

echo -e "\n* generate .env"
cp .env_examples .env
echo -e "ROOT_PASS=$root_pass
DB_NAME=wordpress
DB_USER=user
DB_PASS=$db_pass" >> .env

echo -e "\n* replace wp-config.php data"
cp $site_dir/wp-config-sample.php $site_dir/wp-config.php
sed -i "s/database_name_here/wordpress/; s/username_here/user/; s/password_here/$db_pass/; s/localhost/db/" $site_dir/wp-config.php

echo -e "\n* deploy docker-compose.yml" 
docker-compose up -d;

echo -e "\n* waiting 10 sec"
sleep 10

echo -e "\n* importing db"
docker exec -i lemp_stack_pipeline_db_1   mysql -uuser -p$db_pass wordpress < data/wordpress.sql
