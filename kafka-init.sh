#!/bin/bash

ZK_CONNECT=$1
BROKER_ID=$2

if [ -n "$ZK_CONNECT" ]
then
  echo 'delete.topic.enable = true' >> $KAFKA_HOME/config/server.properties
  sed -i 's/^zookeeper.connect=.*/zookeeper.connect='$ZK_CONNECT'/' $KAFKA_HOME/config/server.properties
  sed -i 's/^broker.id=.*/broker.id='$BROKER_ID'/' $KAFKA_HOME/config/server.properties
  trap "$KAFKA_HOME/bin/kafka-server-stop.sh; echo 'Kafka stopped.'; exit" SIGHUP SIGINT SIGTERM
  $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties > $KAFKA_HOME/kafka.log
fi