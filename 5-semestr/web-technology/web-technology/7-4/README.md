# Implementing Custom Exception Handling in a Spring RESTful Service

By completing these steps, you will successfully integrate custom exception handling into your Spring RESTful service, improving its robustness and user-friendliness by providing clear, specific feedback for error conditions such as resource-not-found scenarios.

Duration: _30 min_

## Description

The basic setup for the application is provided. The RESTful service provides an API for retrieving a product by its ID. The current setup uses in-memory storage for existing resources, but feel free to provide your own implementation.

For this task, you will focus on a case when a resource requested by a client cannot be found in the system. In this case, the API should respond with the `404` status code, and the body of the response should provide additional details.

## Requirements

To consider the task complete, the following criteria must be met:

1. The application starts successfully on a servlet container and can accept requests.
2. The API gracefully handles cases where a requested resource is not found in the system.

## Steps

1. Create a custom exception class, e.g., `ProductNotFoundException`, under the `exception` package. 
2. Implement the `getProductById` method in the `ProductService` class. This method should check if the product exists for a given ID and throw a `ResourceNotFoundException` if not found. 
3. Add exception-handling logic to the application's `GlobalExceptionHandler` class (there is an empty class in the project). Utilize the Spring framework's tools for handling exceptions.  
4. If needed, add additional fields or getters/setters to the `Product` class. 
5. Build a `war` file using Maven. 
6. Deploy and run your application on a servlet container like Tomcat. Use tools like Postman or CURL to test the application against the `/products` endpoint. Test the application by trying to fetch existing resources and resources that are not present in the system. 

## Examples

Below are some examples of creating requests using the CURL utility for API testing. Adjust them according to your specific implementation as necessary.

##### Existing product

```
curl -i --location 'http://localhost:8080/task04-rest-project-task-1.0-SNAPSHOT/products/1001'
```

The response status should be `200`, and the body of the response in JSON should be:

```
{
    "id": 1001,
    "name": "Laptop",
    "description": "High-performance laptop with SSD storage",
    "price": 1200
}
```

##### There is no product specified

```
curl -i --location 'http://localhost:8080/task04-rest-project-task-1.0-SNAPSHOT/products/1005'
```

The response status should be `404`, and, depending on your implementation, the body of the response should contain an error message like the following:

```
Resource with ID 1005 not found.
```
