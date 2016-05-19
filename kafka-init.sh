#!/bin/bash

ZK_CONNECT=$1
BROKER_ID=$2

IPADDRESS=`ip -4 addr show scope global dev eth0 | grep inet | awk '{print \$2}' | cut -d / -f 1`

if [ -n "$ZK_CONNECT" && -n "$BROKER_ID" ]
then
  echo 'delete.topic.enable=true' >> $KAFKA_HOME/config/server.properties
  sed -i 's/^zookeeper.connect=.*/zookeeper.connect='$ZK_CONNECT'/' $KAFKA_HOME/config/server.properties
  sed -i 's/^broker.id=.*/broker.id='$BROKER_ID'/' $KAFKA_HOME/config/server.properties
  sed -i 's/^#advertised.host.name=.*/advertised.host.name='$IPADDRESS'/' $KAFKA_HOME/config/server.properties

  if [ -n "$NUM_PARTITIONS" ]
  then sed -i 's/^num.partitions=.*/num.partitions='$NUM_PARTITIONS'/' $KAFKA_HOME/config/server.properties
  fi

  if [ -n "$DEFAULT_REPLICATION_FACTOR" ]
  then echo "default.replication.factor=$DEFAULT_REPLICATION_FACTOR" >> $KAFKA_HOME/config/server.properties
  fi

  trap "$KAFKA_HOME/bin/kafka-server-stop.sh; echo 'Kafka stopped.'; exit" SIGHUP SIGINT SIGTERM
  $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
fi