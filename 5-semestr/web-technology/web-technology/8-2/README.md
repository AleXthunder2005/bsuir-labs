# Configuring a Spring Boot Application

By completing this task, you will master how to manage application configurations for different environments using Spring Boot. This practice is essential for developing applications that are flexible and adaptable to any deployment environment.

Duration: _~1 hour 30 min_

## Description

This task is designed to deepen your understanding of how to configure Spring Boot applications, with a focus on utilizing `application.properties` or `application.yml` for different environments (development, testing, and production). You will learn how to manage and segregate configuration properties to ensure your application can adapt to various environments seamlessly. 

## Steps

**Step 1**: Define configuration properties inside the `src/main/resources` directory, and create three different application properties files if missing:

- application-dev.properties (for the development environment) 
- application-test.properties (for the testing environment) 
- application-prod.properties (for the production environment) 

**Step 2**: Add a sample configuration to `application.properties`. This file will contain common configurations that are not environment-specific: ```spring.application.name=bookstore-app```.

**Step 3**: Add sample configurations to environment-specific property files. The property should have a value of an environment name—for example: ```bookstore.app.environment.name=dev```.

**Step 4**: The class `ConfigurationDetailsProvider` inside the service package has a method called `getAppName`, which returns the name of an application in the form of a string in which the name of the base app name and the environment are separated by a hyphen. Use Spring's `@Value` annotation to populate the values of the base name and the environment from the application configurations.

**Step 5**: Create an `EnvController` class inside the `controller` package that will expose the `envDetails` GET API. The controller should use the `ConfigurationDetailsProvider` mentioned before to build and return a message containing the environment-specific name of the application—for example: `Application Name: bookstore-app-myenv`.

**Step 6**: There is a section for configuring a database inside `application-dev.properties`. It serves as an example of a real-world application in which an application needs to point to different databases, depending on the environment the application is deployed to. You can try implementing a simple bookstore functionality within the application with different databases (in memory, installed on your machine, or provided by AWS, for example) for different environments.

**Step 7**: To run your application with a specific profile, use the Spring Boot Maven plugin command with the goal `spring-boot:run` and specify the `spring.profiles.active` property—for example, to run with the development profile: ```mvn spring-boot:run -Dspring-boot.run.profiles=dev```.

## Requirements

The task is considered complete if the following conditions are met: 

1. The application starts successfully. 
2. A GET request to `/envDetails` responds with a 200 OK status code and the correct environment-specific name of the application in the response body.

## Examples

An example of a call to the API served by the Spring Boot application:

```
curl --location 'http://localhost:8080/envDetails'
```

should return:

```Application Name: bookstore-app-test```
