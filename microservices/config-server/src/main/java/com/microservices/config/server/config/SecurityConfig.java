package com.microservices.config.server.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;

@Configuration
public class SecurityConfig {
    // for semplicity skip the control on encrpyt/decrypt and actuator endpoints, NOT ALLOWED IN PRODUCTION!
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring()
                .antMatchers("/actuator/**")
                .antMatchers("/encrypt/**")
                .antMatchers("/decrypt/**");
    }
}
