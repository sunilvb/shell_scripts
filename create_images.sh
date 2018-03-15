#!/bin/bash

mkdir service_s1
cp billing-producer.jar service_s1/billing-producer.jar
cp Dockerfile_s1 service_s1/Dockerfile
cd service_s1
docker build -t s1 .

sleep 2
cd ..
rm -r service_s1
mkdir service_s2
cp billing-consumer.jar service_s2/billing-consumer.jar
cp Dockerfile_s2 service_s2/Dockerfile
cd service_s2
docker build -t s2 .

