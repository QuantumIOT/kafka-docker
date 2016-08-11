FROM java:openjdk-8-jre-alpine

RUN apk add --no-cache wget bash jq coreutils curl tar

RUN mkdir -p ~/Downloads
ADD download-kafka.sh /tmp/download-kafka.sh
ENV KAFKA_VERSION="0.9.0.1" SCALA_VERSION="2.11"
RUN /tmp/download-kafka.sh && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

EXPOSE 9092

ADD kafka-init.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/kafka-init.sh"]