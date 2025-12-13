# Connecting Spring Boot to a Relational Database Using a JDBC Template

Through this task, you will learn how to use a JDBC template in Spring Boot for database operations.

Duration: _1 hours_


## Description

This task aims to teach you how to integrate a Spring Boot application with a relational database using a JDBC template. You will learn to perform various database operations like create, read, update, and delete (CRUD) within a Spring Boot application. The subject area for this task will be a simple library management system in which you will manage a list of books.

## Steps
- Configure the datasource in `application.properties` or `application.yml`.
- Implement `BookRepository` using `JdbcTemplate`/`NamedParameterJdbcTemplate`.
- Implement endpoints to perform CRUD operations.
- Use tools like Postman to test your service.

## Requirements:
- Use Maven as the build tool.
- Create a Spring Boot application that connects to a relational database (e.g., H2 or MySQL) using a JDBC template.
- Implement CRUD operations to manage books in the library.
- Test your service.
