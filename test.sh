#!/bin/bash

function error {
  echo -e "\nERROR: $1";
  exit 1;
}

echo "* start testing"

echo -e "\n* check running containers"
number_up=`docker-compose ps | grep Up | wc -l`
docker-compose ps
if [ $number_up -ne "3" ]; then 
  
  error "some containers is down"; 

fi
echo -e "\n* checking http status"
curl -I http://localhost
[[ `curl -Is http://my-registry.pp.ua | grep '200 OK'` ]] || error "bad http status";

docker-compose down
