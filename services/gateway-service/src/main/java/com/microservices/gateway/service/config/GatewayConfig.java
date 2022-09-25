package com.microservices.gateway.service.config;

import com.microservices.config.GatewayServiceConfigData;
import io.github.resilience4j.circuitbreaker.CircuitBreakerConfig;
import io.github.resilience4j.timelimiter.TimeLimiterConfig;
import org.springframework.cloud.circuitbreaker.resilience4j.ReactiveResilience4JCircuitBreakerFactory;
import org.springframework.cloud.circuitbreaker.resilience4j.Resilience4JConfigBuilder;
import org.springframework.cloud.client.circuitbreaker.Customizer;
import org.springframework.cloud.gateway.filter.ratelimit.KeyResolver;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import reactor.core.publisher.Mono;

import java.time.Duration;
import java.util.Objects;

@Configuration
public class GatewayConfig {

    private final GatewayServiceConfigData gatewayServiceConfigData;

    private static final String HEADER_FOR_KEY_RESOLVER = "Authorization";

    public GatewayConfig(GatewayServiceConfigData configData) {
        this.gatewayServiceConfigData = configData;
    }

    @Bean(name = "authHeaderResolver")
    KeyResolver userKeyResolver() {
        return exchange -> Mono.just(Objects.requireNonNull(exchange
                .getRequest().getHeaders().getFirst(HEADER_FOR_KEY_RESOLVER)));
    }

    @Bean
    Customizer<ReactiveResilience4JCircuitBreakerFactory> circuitBreakerFactoryCustomizer() {
        return reactiveResilience4JCircuitBreakerFactory ->
                reactiveResilience4JCircuitBreakerFactory.configureDefault(id -> new Resilience4JConfigBuilder(id)
                        .timeLimiterConfig(TimeLimiterConfig.custom()
                                .timeoutDuration(Duration.ofMillis(gatewayServiceConfigData.getTimeoutMs()))
                                .build())
                        .circuitBreakerConfig(CircuitBreakerConfig.custom()
                                .failureRateThreshold(gatewayServiceConfigData.getFailureRateThreshold())
                                .slowCallRateThreshold(gatewayServiceConfigData.getSlowCallRateThreshold())
                                .slowCallDurationThreshold(Duration.ofMillis(gatewayServiceConfigData
                                        .getSlowCallDurationThreshold()))
                                .permittedNumberOfCallsInHalfOpenState(gatewayServiceConfigData
                                        .getPermittedNumOfCallsInHalfOpenState())
                                .slidingWindowSize(gatewayServiceConfigData.getSlidingWindowSize())
                                .minimumNumberOfCalls(gatewayServiceConfigData.getMinNumberOfCalls())
                                .waitDurationInOpenState(Duration.ofMillis(gatewayServiceConfigData
                                        .getWaitDurationInOpenState()))
                                .build())
                        .build());
    }

}
