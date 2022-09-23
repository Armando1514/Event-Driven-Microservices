package com.microservices.kafka.streams.service.security;

import com.microservices.config.KafkaStreamsServiceConfigData;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.OAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2TokenValidatorResult;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;

@Qualifier(value = "kafka-streams-service-audience-validator")
@Component
public class AudienceValidator implements OAuth2TokenValidator<Jwt> {

    private final KafkaStreamsServiceConfigData kafkaStreamsServiceConfig;

    public AudienceValidator(KafkaStreamsServiceConfigData config) {
        kafkaStreamsServiceConfig = config;
    }

    public OAuth2TokenValidatorResult validate(Jwt jwt) {
        if (jwt.getAudience().contains(kafkaStreamsServiceConfig.getCustomAudience())) {
            return OAuth2TokenValidatorResult.success();
        } else {
            OAuth2Error audienceError =
                    new OAuth2Error("invalid_token", "The required audience " +
                            kafkaStreamsServiceConfig.getCustomAudience() + " is missing!",
                            null);
            return OAuth2TokenValidatorResult.failure(audienceError);
        }
    }
}
