#!/bin/bash


printf "Stopping the Kafka and Zookeeper Cluster...\n\n"
docker-compose down
sleep 10

# Kill all running billing miscoservices
printf "\n\nKilling all billing microservices...\n\n"
kill -9 `ps -ef | grep billing | grep -v grep | awk '{print $2}'`

printf "\nAll Done...\n\n"