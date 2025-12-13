package com.epam.edu.springbootappconfiguration.controller;

import com.epam.edu.springbootappconfiguration.service.ConfigurationDetailsProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EnvController {

    private final ConfigurationDetailsProvider configurationDetailsProvider;

    @Autowired
    public EnvController(ConfigurationDetailsProvider configurationDetailsProvider) {
        this.configurationDetailsProvider = configurationDetailsProvider;
    }

    @GetMapping("/envDetails")
    public String envDetails() {
        return "Application Name: " + configurationDetailsProvider.getAppName();
    }
}

