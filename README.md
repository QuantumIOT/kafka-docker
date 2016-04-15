# Kafka

This docker image allows to deploy a multi node Kafka cluster using an existing Zookeeper cluster. Heavily inspired by wurstmeister/kafka image.

`zookeeper.connect` and `brokedID` Kafka configuration parameters must manually specified.

Command format:

```
docker run --net host -d -p 9092:9092 --name [name] qiot/kafka [zookeeper.connect string] [brokerID]
```

Example:

```
docker run --net host -d -p 9092:9092 --name Kafka-broker-1 qiot/kafka "111.111.111.111:2181,222.222.222.222:2181,121.121.121.121:2181" 1
```

