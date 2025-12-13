# Hibernate Entity Relationships in Spring Boot

By completing this task, you will learn how to define entities and their relationships using Hibernate in a Spring Boot application. Implementing the repository and service layers will also introduce you to the concept of a layered architecture, providing a clear separation of concerns within your application.

Duration: _4 hours_


## Description

The goal of this task is to learn how to create entities and repositories to interact with a database using Hibernate within a Spring Boot application. You'll implement basic entity relationships such as one-to-one, one-to-many, many-to-one, and many-to-many. Additionally, you'll apply the layered architecture pattern using Spring Core to structure your application. The subject area for this task will be a simplified e-commerce system in which you will manage products, orders, customers, and categories.

## Steps

- Configure the datasource in `application.properties` or `application.yml`.
- Define Entity classes and relationships:
  - Product and Category - many-to-one relationship (each product belongs to one category; a category can have many products) 
  - Order and Product - many-to-many relationship (orders can contain multiple products; products can be part of multiple orders).
  - Customer and Order - one-to-many relationship (a customer can have multiple orders) 
- For each entity, create an interface in the repository package that extends `JpaRepository`.
- Implement controllers to handle the following operations for each entity: get all items, get item by ID, create item, update item, and delete item. Use @RestController to make them RESTful controllers.
- Create service interfaces and implementations for handling business logic.
- Use tools like Postman to test your service.

## Requirements

- Use Maven as the build tool.
- Create a Spring Boot application configured with Spring Data JPA and Hibernate.
- Define entity classes for products, orders, customers, and categories with appropriate relationships.
- Implement repositories to perform CRUD operations on these entities.
- Structure the application using a layered architecture (Controller, Service, Repository).
