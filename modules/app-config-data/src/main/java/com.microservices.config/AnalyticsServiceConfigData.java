package com.microservices.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Data
@Configuration
@ConfigurationProperties(prefix = "analytics-service")
public class AnalyticsServiceConfigData {
    private String version;
    private String customAudience;
}