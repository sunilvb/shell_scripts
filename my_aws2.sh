ssh -i "Kafka-POT.pem" ec2-user@ec2-18-220-225-84.us-east-2.compute.amazonaws.com

scp -i "Kafka-POT.pem" *.jar ec2-user@ec2-18-220-225-84.us-east-2.compute.amazonaws.com:~