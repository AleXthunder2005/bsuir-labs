# Implementing a Basic Spring REST Application

This application demonstrates the basic setup of a Spring MVC application without Spring Boot, focusing on manual configuration, including a basic REST controller. This setup serves as a foundation for understanding how Spring works under the hood and for building more complex applications.

Duration: _1 hours_

## Description

Your task is to create a simple Spring REST application that manually configures a REST controller. This application will demonstrate the fundamentals of the Spring framework. Java will be used to configure the definintions of the beans and their dependencies in order to set up a RESTful service endpoint.

### Requirements:
- Project Setup: Create a Maven project with dependencies for Spring Web MVC.  
- Java Configuration: Use a Java configuration to define your Spring application context and REST controller bean.  
- REST Controller: Implement a REST controller that handles HTTP GET requests and returns a simple message.  
- The application must be configured without using Spring Boot. 
- A running Spring MVC application that responds to an HTTP GET request with a simple message, demonstrating manual configuration of a Spring context and REST controller 

### Steps
1. Create a Maven project and add dependencies for Spring Web MVC in `pom.xml`:  
2. Create a Java Config class that configures Spring MVC. This class should enable `@EnableWebMvc` and implement `WebMvcConfigurer`.  
3. Create a REST controller. This controller will handle HTTP GET requests and return a simple message.  
4. Create a Servlet Initializer to replace web.xml. This class will set up the DispatcherServlet.  
5. Deploy your application to a servlet container like Tomcat. Access the application via the URL that corresponds to your servlet container's configuration, which is typically something like the following: `http://localhost:8080/yourAppName/hello`.
