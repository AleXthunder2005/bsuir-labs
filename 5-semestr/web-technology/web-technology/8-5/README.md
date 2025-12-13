# Spring Boot Security: Database Authentication and Basic Authorization

By completing this task, you'll learn how to configure Spring Security to authenticate a database and secure REST APIs with basic authorization based on user roles. This setup is crucial for protecting sensitive information and ensuring that only authorized users can perform certain operations within an application.

Duration: _1 hour_.

## Description

The goal of this task is to integrate Spring Security into a Spring Boot application to manage authentication and authorization using a database. You will secure REST APIs by implementing basic authorization techniques.

The subject area for this task will be a simple content management system (CMS) in which users can create, read, update, and delete articles, but only authenticated users with the right roles can perform these operations.

## Steps

1. Define a connection to the database of your choice.
2. Create entity classes and repositories for `User` and `Role` for authentication and authorization.
3. Populate the database with `USER` and `ADMIN` roles and corresponding users.
4. Create entity classes and repositories for `Article` to manage the actual content of the application on the database layer.
5. Create controllers for creating, reading, and deleting articles.
6. Configure security to allow users to read articles and admin to create and delete articles.

You'll see how easy it is to do this using Spring Boot. For example, the whole configuration of Datasource can be defined in the `application.properties` or `application.yml` file without a line of code. 

### Database layer 

Choose a database (e.g., Postgres, MySQL, or H2) and configure the connection via `application.properties`. The following is an example of an H2 connection:

```properties
spring.datasource.url=jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password

spring.jpa.database-platform=org.hibernate.dialect.H2Dialect

spring.jpa.properties.hibernate.globally_quoted_identifiers=true
```

Datasource is pretty standard for an H2 database, and so is `spring.jpa.database-patform`.

The `globally_quoted_identifiers` property must be set if you're going to use tables with names that clash with reserved keywords such as `user`.

Use Spring Data JPA to create repositories for the tables `user`, `role`, and `article`.
The user table must contain:
* id
* username
* password

The role table must contain:
* id
* name

The article table must contain:
* id
* title
* text

### UserDetailsService 

First, you have to declare your implementation of `UserDetailsService`, a Spring Security interface that allows a user and its roles to be located by name. 

Your implementation must rely on the JPA repository to find user details and throw `UsernameNotFoundException` if no user is found.
The user found must be transformed into `org.springframework.security.core.userdetails.User`. 
For the role, you can use `org.springframework.security.core.authority.SimpleGrantedAuthority` and `ROLE_` prefix (i.e., `new SimpleGrantedAuthority("ROLE_" + customRole)`). 


### Security configuration 

You have to define two main beans to make Spring Security work:
1. `PasswordEncoder`
2. `SecurityFilterChain` 

For password encoder, you can use any existing implementation, but the simplest one is `BCryptPasswordEncoder`. 

`SecurityFilterChain` must be configured as follows:
* It must require authentication for all requests.
* Write requests for `/article/**` path must only be authorized if a user has the role `ADMIN`.
* Your implementation of `UserDetailsService` must be used to locate users.
* Form log-in, log-out, and CSRF must be disabled.
* The session creation policy must be set to `STATELESS`.

Endpoints must be accessible when the `Authorization` header is passed. To complete this task, it'll be enough to implement only `Basic` authorization. For example, for the user `admin` with the password `admin`, the GET article will look like the following:
```http request
GET localhost:8080/article/hello-world
Authorization: Basic YWRtaW46YWRtaW4=
```

### Article functionality 

You must define four endpoints: 

1. `GET /article/{title}` returns the text of an article by its title or returns HTTP NOT FOUND (404) status if the article does not exist. It is available for all authorized users.
2. `POST /article/{title}` accepts text as a request body and creates an article. If an article already exists, HTTP CONFLICT (409) status must be returned. It is available only for admins.
3. `PUT /article/{title}` accepts text as a request body and updates an existing article or returns HTTP NOT FOUND (404) status if an article does not exist. It is available only for admins.
4. `DELETE /article/{title}` deletes an article if it exists. It is available only for admins.

## Requirements

* CRUD functionality is implemented for articles.
* The endpoint GET is available for all authorized users.
* The endpoints POST, PUT, and DELETE are available only for admins.
* Users and roles are stored in the database.
* Authorization is implemented via the `Authorization` header.
* The 404 (NOT_FOUND) status code is returned when an attempt to fetch or update a nonexistent article is made.
* The 409 (CONFLICT) status code is returned when an attempt to create an article that already exists is made.
