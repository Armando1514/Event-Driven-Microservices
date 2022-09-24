package com.microservices.discovery.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@EnableEurekaServer
@SpringBootApplication
public class ServiceRegistrationAndDiscoveryServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(ServiceRegistrationAndDiscoveryServiceApplication.class, args);
    }

}