# Implementing a RESTful Controller for a Person Entity

The purpose of this task is to use Spring MVC to create a RESTful service capable of managing Person entities with a focus on REST principles and proper use of HTTP methods. This task will solidify your understanding of how to develop RESTful services with Spring.

Duration: _~30 minutes_

## Description

Develop a RESTful controller for managing Person entities using Spring MVC. Your application should support the full spectrum of CRUD operations (create, read, update, delete) through RESTful principles. This task emphasizes the correct use of the HTTP methods and annotations provided by Spring MVC.

## Requirements
- The application starts correctly on a servlet container and can perform basic CRUD operations via the REST API. 
- The API is implemented using the correct HTTP methods, and the names of endpoints comply with REST API naming conventions https://restfulapi.net/resource-naming/. 

## Steps
1. Add more fields to that `Person` class that can be used to describe a person—for example first name, last name, age, etc. 
2. Provide an implementation to allow the `CrudService` interface to handle `Person` entities. For simplicity, you can use a `Map`, or you can come up with your own solution. The program must ensure that data can be stored at least for the duration of its operation.
3. Add the required code to `PersonController` so that it serves as a RESTful controller that provides an API for CRUD operations. Use the correct HTTP methods and annotations provided by Spring MVC. 
4. Build an application artifact using Maven. 
5. Run your application on a servlet container like Tomcat. Use Postman or curl to test the CRUD operations against your `/people` endpoints, ensuring each HTTP method behaves as expected.

## Examples

Request examples for API testing. Adjust according to your specific implementation:

##### GET

```
curl --location 'http://localhost:8080/rest-project-1.0-SNAPSHOT/people/1'
```

##### POST

```
curl --location 'http://localhost:8080/rest-project-1.0-SNAPSHOT/people' \
--header 'Content-Type: application/json' \
--data '{
"id": 1,
"name": "John Smith"
}'
```

##### PUT

```
curl --location --request PUT 'http://localhost:8080/rest-project-1.0-SNAPSHOT/people/1' \
--header 'Content-Type: application/json' \
--data '{
    "id": 1,
    "name": "John Connor"
}'
```

##### DELETE

```
curl --location --request DELETE 'http://localhost:8080/rest-project-1.0-SNAPSHOT/people/1'
```
