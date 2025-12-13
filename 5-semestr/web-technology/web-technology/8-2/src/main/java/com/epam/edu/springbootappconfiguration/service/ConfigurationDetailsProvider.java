package com.epam.edu.springbootappconfiguration.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class ConfigurationDetailsProvider {

    private static final String APP_NAME_FORMAT = "%s-%s";

    @Value("${spring.application.name}")
    private String baseName;
    
    @Value("${bookstore.app.environment.name}")
    private String environment;

    public String getAppName() {
        return String.format(APP_NAME_FORMAT, baseName, environment);
    }
}
