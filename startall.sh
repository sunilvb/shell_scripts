#!/bin/bash

set -e

if [[ $# -eq 0 ]] ; then
    printf 'Error running script....\n Please pass 2 valid arguments like 10 YES or 100 NO or 1000 YES'
	printf 'First argument is reset count. Second argument is flag to by-pass Pega'	
    exit 0
fi

printf "Stopping the Kafka and Zookeeper Cluster...\n\n"
docker-compose down
sleep 10

# Kill all running billing miscoservices
printf "\n\nKilling all billing microservices...\n\n"
kill -9 `ps -ef | grep billing | grep -v grep | awk '{print $2}'`

printf "Strating the Kafka and Zookeeper Cluster...\n\n"
docker-compose up -d
sleep 10
docker ps

printf "copying s7.jar to s7b.jar\n\n"
cp billing-s7.jar billing-s7b.jar

rm *.log

printf "*********************\n"
printf "Starting Producer Service...\n\n"

java -jar billing-producer.jar > s1.log &
sleep 8
tail -5 s1.log

printf "*********************\n"
printf "Starting Consumer Service...\n\n"

java -jar billing-consumer.jar > s2.log &
sleep 8
tail -5 s2.log

printf "*********************\n"
printf "Starting Eureka Discovery Service...\n\n"

java -jar billing-disc.jar > disc.log &
sleep 8
tail -5 disc.log

printf "*********************\n"
printf "Starting S3 Event Service...\n\n"

java -jar billing-s3.jar > s3.log &
sleep 8
tail -5 s3.log

printf "*********************\n"
printf "Starting S8 Reporting Service...\n\n"

java -jar billing-s8.jar > s8.log &
sleep 8
tail -5 s8.log

printf "*********************\n"
printf "Starting S9 Product Service...\n\n"

java -jar billing-s9.jar > s9.log &
sleep 8
tail -5 s9.log

printf "*********************\n"
printf "Starting Zuul Service...\n\n"

java -jar billing-zuul.jar > zuul.log &
sleep 8
tail -5 zuul.log


printf "*********************\n"
printf "Starting S4...\n\n"

java -jar billing-s4.jar > s4.log &
sleep 8
tail -5 s4.log

curl localhost:8084/load

printf "*********************\n"
printf "Starting S5...\n\n"

java -jar billing-s5.jar > s5.log &
sleep 8
tail -5 s5.log
curl localhost:8085/load

printf "*********************\n"
printf "Starting S6...\n\n"

java -jar billing-s6.jar > s6.log &
sleep 8
tail -5 s6.log
curl localhost:8086/load

printf "*********************\n"
printf "Starting S7...\n\n"

java -jar billing-s7.jar --pega.bypass=$2 > s7.log &
sleep 8
tail -5 s7.log
curl localhost:8087/load

printf "*********************\n"
printf "Starting S7b...\n\n"

java -jar billing-s7b.jar --pega.bypass=$2 --server.port=8097 > s7b.log &
sleep 8
tail -5 s7b.log
curl localhost:8097/load

printf "*********************\n"
printf "Starting sPega == The Alternate Service == ...\n\n"

java -jar billing-sPega.jar > sp.log &
sleep 8
tail -5 sp.log

printf "********************\n Strating reset\n\n"
sh ./reset.sh $1
sleep 2
printf "\n\n==============================================\n"
printf "************** ALL DONE !! :-) **************\n\n"
printf "\n\n==============================================\n\n"
ps -ef | grep 'billing' 

