# Kafka

This docker image allows to deploy a multi node Kafka cluster using an existing Zookeeper cluster. Heavily inspired by wurstmeister/kafka image.

`zookeeper.connect` and `brokedID` Kafka configuration parameters must manually specified.

Command format:

```
docker run --net=your-net -d -p 9092:9092 --name [name] qiot/kafka [zookeeper.connect string] [brokerID]
```

You can use environment variables to set:
- `default.replication.factor` ($DEFAULT_REPLICATION_FACTOR)
- `num.partitions` ($NUM_PARTITIONS)

Example:

```
docker run --net=your-net -d -p 9092:9092 -e DEFAULT_REPLICATION_FACTOR="2" --name kafka1 qiot/kafka "111.111.111.111:2181,222.222.222.222:2181,121.121.121.121:2181" "1"
```

