package com.microservices.query.service.security;

import com.microservices.config.ElasticQueryServiceConfigData;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.OAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2TokenValidatorResult;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;

@Qualifier("elastic-query-service-audience-validator")
@Component
public class AudienceValidator implements OAuth2TokenValidator<Jwt> {

    private final ElasticQueryServiceConfigData elasticQueryServiceConfigData;

    public AudienceValidator(ElasticQueryServiceConfigData configData) {
        this.elasticQueryServiceConfigData = configData;
    }

    @Override
    public OAuth2TokenValidatorResult validate(Jwt jwt) {
        if (jwt.getAudience().contains(elasticQueryServiceConfigData.getCustomAudience())) {
            return OAuth2TokenValidatorResult.success();
        } else {
            OAuth2Error audienceError =
                    new OAuth2Error("invalid_token", "The required audience " +
                            elasticQueryServiceConfigData.getCustomAudience() + " is missing!",
                            null);
            return OAuth2TokenValidatorResult.failure(audienceError);
        }
    }
}