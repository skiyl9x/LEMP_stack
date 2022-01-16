#!/bin/bash
 
docker-compose down

echo "* generate db passwords"
root_pass=`date +%s | sha256sum | base64 | head -c 32 ; echo` #root mysql pass
db_pass=`date +%s | sha256sum | base64 | head -c 32 ; echo` #wordpress db pass

echo "* generate .env"
echo -e "ROOT_PASS=$root_pass
DB_NAME=wordpress
DB_USER=user
DB_PASS=$db_pass" > .env

echo "* replace wp-config.php data"
cp ./data/site_wp/wp-config-sample.php ./data/site_wp/wp-config.php
sed -i "s/database_name_here/wordpress/" ./data/site_wp/wp-config.php
sed -i "s/username_here/user/" ./data/site_wp/wp-config.php
sed -i "s/password_here/$db_pass/" ./data/site_wp/wp-config.php
sed -i "s/localhost/db/" ./data/site_wp/wp-config.php
echo "* deploy docker-compose.yml"
docker-compose up -d


echo "* import wordpress.sql to wordpress db"
container_id=`docker ps --filter "expose=3306" --format "table {{.ID}}" | tail -1`
echo "* waiting 10 sec"
sleep 10
echo "* importing db"
docker exec -i lemp_stack_pipeline_db_1   mysql -uuser -p$db_pass wordpress < wordpress.sql
