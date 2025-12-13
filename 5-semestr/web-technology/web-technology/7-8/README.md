# University Model - REST

The goal of this task is to give you some practice using major Spring REST concepts.

## Description

Your goal is to practice using Spring REST technologies to see how they can be used to represent data.

You can use either the JPA, Hibernate, or Spring MVC task as a base for this task. 
You can reuse the codebase from one of these tasks, or you can start from scratch and create a new one.

In other words, your database layer should already be working.
If you have decided to reuse Spring MVC, please be aware that not everything related to the UI will be needed here.

The main goal of this assignment is to practice using the basic principles of Spring REST.
Your solution doesn't need to support all the functionality of the JPA and Hibernate tasks; it only needs to cover the functionality described below.

## Requirements

To complete the task, follow the steps below:

1. Implement CRUD endpoints for students.
2. Implement CRUD endpoints for courses.
3. Implement error handling using `@ControllerAdvice` or `@RestControllerAdvice`.
4. All input DTOs must be validated using Jakarta.

#### CRUD endpoints explanation

For example, here is the list of endpoints that need to be implemented for students:

##### GET /student

Returns a page of students

Has the following request parameters:
- size — page size. Not required. The default value is 10.
- page — page number. Not required. The default value is 0.

For example, suppose you have a total of 10 students. Here is what the request/response pairs should look like:

```http request
###
GET {{app}}/student

# response
{
    "content": [
        <1>,
        <2>,
        <3>,
        <4>,
        <5>,
        <6>,
        <7>,
        <8>,
        <9>,
        <10>,
    ],
    "size": 10,
    "page": 0
}

###
GET {{app}}/student?size=2

# response
{
    "content": [
        <1>,
        <2>
    ],
    "size": 2,
    "page": 0
}

###
GET {{app}}/student?size=2&page=3

# response
{
    "content": [
        <7>,
        <8>
    ],
    "size": 2,
    "page": 3
}

###
GET {{app}}/student?size=3&page=3

# response
{
    "content": [
        <10>
    ],
    "size": 3,
    "page": 3
}
```

The exact names of the fields are up to you.
`<1>` means a student DTO with all the required for fields for a student with id = 1.

##### GET /student/{id}

The `id` is a required path variable. It must return the same DTO as in the previous example.
If no student with the provided `id` is found, the NOT_FOUND (404) status should be returned.

##### POST /student

Accepts JSON as a body. Describe the body as a class (it can be named StudentCreateRequest, for example).
Annotate this class using Jakarta validation annotations.

Calling this endpoint is equivalent to two actions:
1. Creating a student
2. Calling `GET /student/{id}` for a newly created student

You can either return a student DTO from this method directly or redirect to `GET /student/{id}`.

If an invalid request is passed, the BAD_REQUEST (400) status should be returned.
If a student can't be created using this request, the UNPROCESSABLE_ENTITY (422) status should be returned.

##### PUT /student/{id}

The `id` is a required path variable. It accepts JSON as a body.
Describe a separate DTO for an update request (e.g., StudentUpdateRequest) and annotate it using Jakarta.

If no student with this `id` exists, the the NOT_FOUND (404) status should be returned.
If the request is invalid, the BAD_REQUEST (400) status should be returned.
If a student cannot be updated, the UNPROCESSABLE_ENTITY (422) status should be returned.

Return the student DTO with the updated fields.
