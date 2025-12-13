# Developing a Web Application With Spring REST, Hibernate, and Spring Security

Build a comprehensive web application utilizing Spring REST for back-end services, Hibernate for ORM, and Spring Security for managing user authentication and authorization. The application will feature user sign-up, log-in functionalities, and access control mechanisms to regulate access to various sections of the application based on user roles. It will also support additional actions typical for a user-centric application, such as profile viewing and editing.

Duration: _4 hours_


## Description

A fully functional web application that demonstrates integration of Spring REST, Hibernate, and Spring Security. This application should provide a secure user authentication system, role-based access control, and a set of services for user-related actions.

## Steps
1. Initialize your Maven project and specify the required dependencies in your `pom.xml` file.
2. Set up Hibernate using Java Configuration and define your `DataSource`, `EntityManagerFactory`, and `TransactionManager`.
3. Configure `SecurityFilterChain` and define a custom `UserDetailsService`, making sure to override methods to set up log-in, log-out, and access control rules.
4. Create `User` and `Role` entities to represent users and their roles in the database. Use `jakarta.persistence` annotations to map these entities.
5. Create a custom `UserDetailsService` to load user details from the database for authentication.
6. Implement endpoints for sign-up, profile viewing, and editing.
7. Deploy and test your service.

## Requirements
- Project Setup: Use Maven for project management and dependency resolution.
- Database Integration: Use Hibernate and a relational database of your choice (e.g., MySQL).
- User Authentication and Authorization: Implement user authentication for log-in and authorization to secure parts of the program based the role (e.g., ADMIN or USER).
- User Management: Enable user sign-up and storage of user credentials and roles in the database, and manage session-based user log-in.
- Spring REST Services: Develop RESTful services for handling user actions such as sign-up, log-in, profile viewing, and editing.
- Java Configuration: Use Java Configuration to set up Spring, Hibernate, and Spring Security components.
- Spring Security Configuration: Configure Spring Security for authentication and authorization using a custom user details service or Spring's built-in support.
