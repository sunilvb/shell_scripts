#!/bin/bash

 Kill all running billing miscoservices
printf "\n\nKilling all billing microservices...\n\n"
kill -9 `ps -ef | grep mlab- | grep -v grep | awk '{print $2}'`

mv billing-disc.jar mlab-cog-disc.jar

printf "\n\n<<<<<<<<<  STARTING !! >>>>>>>>>\n\n"

java -jar mlab-cog-disc.jar > ds.log &
sleep 15
tail -8 ds.log
 
java -jar mlab-cog-zuul-0.1.jar > zu.log &
sleep 15
tail -8 zu.log

java -jar mlab-cog-0.1.jar > s1.log &
sleep 15
tail -8 s1.log

java -jar mlab-cog-2-0.1.jar > s2.log &
sleep 15
tail -8 s2.log

java -jar mlab-cog-3-0.1.jar > s3.log &
sleep 15
tail -8 s3.log

ps -ef | grep mlab-
printf "\n\n<<<<<<<<<  ALL DONE !! >>>>>>>>>\n\n"
