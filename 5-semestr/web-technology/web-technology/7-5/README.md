# Integrating Spring's Validation API Into a RESTful Service

Enhance your Spring MVC–based RESTful service by incorporating the Validation API. You will utilize `@Valid` or `@Validated` annotations to activate validation logic while processing POST and PUT requests. Additionally, implement proper error handling to manage and respond to validation errors in a way that is useful to the client. 

Duration: _2 hours_

### Requirements
1. Project Setup: Configure your project with Maven, including dependencies for Spring Web MVC and validation.
2. Integrating Validation: Apply validation annotations to your model class.
3. Controller Modification: Update your controller methods to use `@Valid` or `@Validated` for incoming POST and PUT request payloads.
4. Error Handling: Implement a strategy for catching and responding to validation errors, ensuring that the client receives meaningful feedback.
5. Configuration: Use Java configuration to establish your Spring application context.
6. A fully functional RESTful service that can validate incoming data on POST and PUT requests and clearly communicate any validation errors to the client.

### Steps
1. Initialize your Maven project and specify the required dependencies in your `pom.xml` file.
2. Apply validation constraints to your model class

```java
public class Person {
    private Long id;
    private String name;
    
    // Constructors, getters, and setters
}
```
3. Modify your controller to include @Valid or @Validated annotation on method parameters in POST and PUT operations.
4. Set up an exception handler to manage validation errors. Use `@ControllerAdvice` to catch `MethodArgumentNotValidException`.
5. Configure your Spring MVC application using Java configuration. Ensure your controllers and exception handlers are scanned.
6. Deploy and test your service. Use tools like Postman or CURL to send POST and PUT requests with payloads that both pass and fail the validation constraints you set up in your `Person` model.

## Examples
This request should return the status `400 Bad Request` with the message "Name cannot be blank."
```
curl -X POST http://localhost:8080/api/person \
    -H "Content-Type: application/json" \
    -d '{"id": 1, "name": ""}'
```

This request should succeed and return a `200 OK` status with the person's details.
```
curl -X POST http://localhost:8080/api/person \
    -H "Content-Type: application/json" \
    -d '{"id": 1, "name": "John Doe"}'
```
