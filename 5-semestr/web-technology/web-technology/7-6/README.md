# Securing a Spring RESTful Service With HTTP Basic Authentication

Implement security measures for your Spring MVC–based RESTful service by integrating Spring Security. Your task is to configure HTTP Basic Authentication to protect your REST endpoints. You will define in-memory authentication with specific roles and configure access control for these endpoints based on the roles. This task will be accomplished using Java Configuration to define beans and their dependencies and Maven to manage project dependencies.

Duration: _1 hour_

## Requirements
- Project Setup: Use Maven to manage project dependencies.
- Integrating Spring Security: Integrate Spring Security into your project and configure HTTP Basic Authentication.
- In-Memory Authentication: Define a set of users with credentials and roles stored in the memory.
- Role-Based Access Control: Secure your REST endpoints by specifying which roles can access them.
- Java Configuration: Employ Java configuration to set up your Spring application context and security configuration.
- Dependencies: Your Maven setup must include dependencies for Spring Web MVC and Spring Security.
- A Spring RESTful service that is secured with HTTP Basic Authentication, where access to different endpoints is controlled based on user roles. This will demonstrate how to effectively secure a Spring-based application using in-memory authentication and role-based access control.

## Steps
1. Initialize your Maven project and specify the required dependencies in your `pom.xml` file.
2. Configure `SecurityFilterChain` and `UserDetailsService`.
3. Modify your RESTful controllers to include paths that distinguish between public and private access levels, applying role-based restrictions based on your security configuration.
4. Deploy and test your service. You should be able to access public endpoints without authentication, but private endpoints should require HTTP Basic Authentication credentials.

## Examples
For a public endpoint (no authentication required):
```
curl http://localhost:8080/api/public/test
```

For a private endpoint (authentication required):
```
curl -u user:password http://localhost:8080/api/private/tes
```
