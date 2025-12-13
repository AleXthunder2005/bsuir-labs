package edu.epam.fop.rest.configuration;

import org.springframework.context.annotation.Configuration;

@Configuration
public class HibernateConfiguration {
    // Spring Boot автоматически настраивает DataSource, EntityManagerFactory и TransactionManager
    // при наличии spring-boot-starter-data-jpa и драйвера БД (h2).
    // Мы можем оставить этот класс пустым или настроить конкретные параметры БД в application.properties.
}