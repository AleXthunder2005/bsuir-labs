# Spring Boot Basics and Its Conventions

This task is designed to solidify your understanding of Spring Boot's convention-over-configuration philosophy and how to create a simple RESTful web service.

Duration: _~30 minutes_

## Description

The main goal of this task is to understand the core concepts of Spring Boot, focusing on its starters and auto-configuration mechanism. You will apply this knowledge by creating a basic RESTful web service using Spring Boot, specifically leveraging the `@RestController` and `@RequestMapping` annotations.

## Steps

Step 1: Set Up the Spring Boot Project 

- Open the Spring [Initializr](https://start.spring.io/), a convenient tool that will help you bootstrap your Spring Boot application. 
- Choose "Maven Project" as the project type. 
- Select Java as the language. 
- Fill in the Project Metadata fields. Set Group to `com.epam.edu` and Artifact and Name to `spring-boot-basics`. 
- Add the Spring Web dependency by searching for it and selecting it (use the "Add Dependencies" button on the right). 
- Click "Generate" to download your project template. 

Step 2: Extract and Import the Project 

- Extract the downloaded ZIP file. 
- Import the project into your favorite IDE (e.g., Eclipse or IntelliJ IDEA) as a Maven project. 

Step 3: Create a REST Controller 

- Navigate to the `src/main/java` directory in your project. 
- Create a new package named `controller`. 
- Inside the controller package, create a new Java class named `HelloController`. 
- Using your knowledge of the Spring framework's tool set for creating RESTful web services, implement a controller method that will serve GET requests on the `/api/hello` URL and respond, for example, with the string "Hello, Spring Boot!" 

Step 4: Run Your Application 

- Navigate to the `src/main/java` directory in your project. 
- Find the main application class named `SpringBootBasicsApplication.java` (the name might be different, depending on the Name attribute you provided in Spring Initializr). 
- Run the application by right-clicking the file and selecting "Run" (the exact option may vary, depending on your IDE). 

## Requirements

The task is considered complete if the following criteria are met: 
1. The application starts successfully either from the IDE or by using CLI. 
2. A GET request to `/api/hello` responds with a 200 OK status code and the correct response body. 

## Examples

An example of a call to the API served by the Spring Boot application:

```
curl --location 'http://localhost:8080/api/hello'
```
