#!/bin/bash
function error {
  if [ $1 -ne 0 ]; then
    echo -e "\n\e[31mERROR: $2\e[0m";
    docker-compose down
    exit 1
  fi;
}

kubectl apply -f k8s/

