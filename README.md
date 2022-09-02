### Kafka Folder

- Kafka-model: Create and hold java object for kafka in Avro format.
- Kafka-admin: Create and verify Kafka topics programmatically.
- Kafka-producer: Use spring-kafka to write Kafka producer implementation.



## HOW TO RUN IT 

Launch docker.

From the microservices folder to create the docker images type in the terminal:

```
mvn clean install -DskipTests
```

Go from terminal in the folder 'docker-compose' and make 'check-config-server-started.sh' runnable:

```
chmod +x check-config-server-started.sh
```

And after type:

```
docker-compose up
```

