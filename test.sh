#!/bin/bash

function error {
  echo -e "\nERROR: $1";
  exit 1;
}

function clear_all {
  echo "* stop all containers"
  docker-compose down
  source .env_examples
  export NGINX_IMAGE PHP_IMAGE MARIADB_IMAGE
  echo "* delete all images"
  docker rmi $NGINX_IMAGE $PHP_IMAGE $MARIADB_IMAGE
}




echo "* start testing"

echo -e "\n* check running containers"
number_up=`docker-compose ps | grep Up | wc -l`
docker-compose ps
if [ $number_up -ne "3" ]; then

  error "some containers is down";

fi
echo -e "\n* checking http status"
curl -I http://my-registry.pp.ua
[[ `curl -Is http://my-registry.pp.ua | grep '200 OK'` ]] || error "bad http status";

clear_all
