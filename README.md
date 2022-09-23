## Architecture Overview

![generalArchitecture](./doc/generalArchitecture.png)

### Kafka Folders

- Kafka-model: Create and hold java object for kafka in Avro format.
- Kafka-admin: Create and verify Kafka topics programmatically.
- Kafka-producer: Use spring-kafka to write Kafka producer implementation.

## SECURITY

Check [this page for more info about security (SSO explaination included).](./SECURITY.md)

## HOW TO RUN IT 

Launch docker.

From the microservices folder to create the docker images type in the terminal:

```
mvn clean install -DskipTests
```

Go from terminal in the folder 'docker-compose' and make 'check-config-server-started.sh' runnable:

```
chmod +x check-config-server-started.sh
chmod +x check-kafka-topics-created.sh
chmod +x create-mapping-elasticsearch.sh
chmod +x check-keycloak-server-started.sh
```

To access the web client on browser, we need to update the DNS with hostnames, because when web-client, for instance, is redirecting to the user login (keycloack), it will do it to http://keycloack-authorization-server:9091 hostname, that is the container running in docker-compose and externally is accessible on localhost:9091. So from the terminal let's type:

```
vi /etc/hosts
```

and after add:

```
127.0.0.1       keycloak-authorization-server
127.0.0.1       elastic-query-service-1
127.0.0.1       elastic-query-service-2
127.0.0.1       elastic-query-web-client-1
127.0.0.1       elastic-query-web-client-2
```

And save.

Now we can run everything from the folder docker-compose typing:

```
docker-compose up
```

You can access the elastic-query-web-client from browser at:

 http://elastic-query-web-client-1:8184/elastic-query-web-client/
