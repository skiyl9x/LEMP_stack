#!/bin/bash
function error {
  if [ $1 -ne 0 ]; then
    echo -e "\n\e[31mERROR: $2\e[0m";
    docker-compose down
    exit 1
  fi;
}

site_dir="./data/site"
echo "* generate db passwords"
root_pass=`date +%s | sha256sum | base64 | head -c 32 ; echo` #root mysql pass
db_pass=`date +%s | sha256sum | base64 | head -c 32 ; echo` #wordpress db pass

echo "* generate .env"
echo -e "ROOT_PASS=$root_pass
DB_NAME=wordpress
DB_USER=user
DB_PASS=$db_pass" > .env

echo "* replace wp-config.php data"
cp $site_dir/wp-config-sample.php $site_dir/wp-config.php; error $? "can't copy file"
stat $site_dir/wp-config.php
sed -i "s/database_name_here/wordpress/" $site_dir/wp-config.php; error $? "can't replase word"
sed -i "s/username_here/user/" $site_dir/wp-config.php; error $? "can't replase word"
sed -i "s/password_here/$db_pass/" $site_dir/wp-config.php; error $? "can't replase word"
sed -i "s/localhost/db/" $site_dir/wp-config.php; error $? "can't replase word"
echo "* deploy docker-compose.yml" 
docker-compose up -d; error $? "can't up containers"

echo "* import wordpress.sql to wordpress db"
container_id=`docker ps --filter "expose=3306" --format "table {{.ID}}" | tail -1`
echo "* waiting 10 sec"
sleep 10
echo "* importing db"
docker exec -i lemp_stack_pipeline_db_1   mysql -uuser -p$db_pass wordpress < wordpress.sql
