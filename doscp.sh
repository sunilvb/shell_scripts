# Simple utility script to copy files to AWS EC2 instance
# Modify the commands as needed

cp /c/Dev_ModLab/java/spring-kafka-producer-consumer/*.yml .
cp /c/Dev_ModLab/java/spring-kafka-producer-consumer/sample-spring-kafka-consumer/build/libs/*.jar .
cp /c/Dev_ModLab/java/spring-kafka-producer-consumer/sample-spring-kafka-producer/build/libs/*.jar .
cp /c/Dev_ModLab/sample-spring-kafka-client/target/*.jar .

scp -i "Kafka-POT.pem" *.yml ec2-user@ec2-18-220-177-81.us-east-2.compute.amazonaws.com:~
scp -i "Kafka-POT.pem" *.jar ec2-user@ec2-18-220-177-81.us-east-2.compute.amazonaws.com:~

rm *.jar
rm *.yml