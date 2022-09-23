package com.microservices.kafka.service;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "com.microservices")
public class KafkaToElasticServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(KafkaToElasticServiceApplication.class, args);
    }
}

