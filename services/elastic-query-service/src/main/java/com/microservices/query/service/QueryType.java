package com.microservices.query.service;


public enum QueryType {

    KAFKA_STATE_STORE("KAFKA_STATE_STORE"), ANALYTICS_DATABASE("ANALYTICS_DATABASE");

    private String type;

    QueryType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }
}
