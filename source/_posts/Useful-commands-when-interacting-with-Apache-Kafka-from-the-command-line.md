title: Useful commands when interacting with Apache Kafka from the command line
date: 2018-11-24 16:50:49
tags: 
  - apache 
  - kafka 
  - avro
---

When developing a new feature that involves [Apache Kafka](https://kafka.apache.org) I like to hook into a topic to check if everything is working as expected. Usually I do this with the Kafka command line tools but I always forget the exact command to run which I have to look from different sources.
This posts tries to put them together in order to have a single place to look them up.

If you are not familiar with Apache Kafka or want to learn about it, check out [their site!](https://kafka.apache.org/)
To give you a rough idea, these are the three core features of Kafka:

<blockquote cite="https://kafka.apache.org/intro" style="text-align: left;">
<i>Publish and subscribe to streams of records, similar to a message queue or enterprise messaging system.</i>
<i>Store streams of records in a fault-tolerant durable way.</i>
<i>Process streams of records as they occur. </i>
<em style="font-size: 0.75em;">- <a href="https://kafka.apache.org/intro">https://kafka.apache.org/intro</a></em>
</blockquote>

In order to follow the example, you need to have the Kafka command line tools installed.
In `brew` you can do that by simply running `brew install kafka`.
If you don't want to install via `brew` or are using linux, you can get kafka like this:
``` bash
curl -OL http://ftp.fau.de/apache/kafka/2.1.0/kafka_2.11-2.1.0.tgz
tar -xzf kafka_2.11-2.1.0.tgz
cd kafka_2.11-2.1.0/
```

You find the cli commands in the `bin/` subdirectory.
All commands used assume that you are using the new-consumer api and that you added the kafka commands to your `PATH` or running them from the `bin/` directory from above.

## How to consume messages from a given Kafka Topic?

### Start to consume from the latest offset
``` bash
kafka-console-consumer --bootstrap-server <one-of-your-brokers> --topic <topic-to-consume>
```

### Consume from the beginning
``` bash
kafka-console-consumer --bootstrap-server <one-of-your-brokers> \
                       --topic <topic-to-consume> \
                       --from-beginning
```

### Consume a fixed amount of messages
``` bash
kafka-console-consumer --bootstrap-server <one-of-your-brokers> \
                       --topic <topic-to-consume> \
                       --max-messages <number-of-messages>
```

### Consume and print the message keys
``` bash
kafka-console-consumer --bootstrap-server <one-of-your-brokers> \
                       --topic <topic-to-consume> \
                       --property print.key=true \
                       --property key.separator="---"
```

This will print your messages in a format like `<message-key>---<message-payload>`.

### Consume messages encoded in Avro

Another cool feature of Kafka is that it plays well with the [Apache Avro](http://avro.apache.org/docs/current/) format. To consume messages encoded in Avro simply run the following command to get the decoded messages.

``` bash
kafka-avro-console-consumer --bootstrap-server <one-of-your-brokers> \
                            --topic <topic-to-consume> \
                            --property schema.registry.url=http://<your-schema-registry>
```

### Move the offset of a specific consumer group forward by consuming messages

``` bash
kafka-console-consumer --bootstrap-server <on-of-your-brokers> \
                       --topic <topic-to-consume> \
                       --max-messages <number-of-messages/moving the offset forward> \
                       --consumer-property group.id=<consumer-group-to-forward-the-offset> > /dev/null
```

I hope you can use this to speed up your work. If there are commands that you are frequently using that are not included here, let me know in the comments so I can add them.


