#!/bin/bash

set -e

printf "Starting the Billing POT File ....\n\n" 

sh reset.sh 100
sleep 2


curl localhost:8080/generateWork
printf "\nAll done...\n"

tail -f s1.log
