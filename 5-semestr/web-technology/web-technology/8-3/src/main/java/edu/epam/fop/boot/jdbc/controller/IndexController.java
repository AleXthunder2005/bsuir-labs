package edu.epam.fop.boot.jdbc.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class IndexController {

    @GetMapping("/")
    public ResponseEntity<Map<String, Object>> index() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Library Management System API");
        response.put("endpoints", Map.of(
            "GET /api/books", "Get all books",
            "GET /api/books/{id}", "Get book by ID",
            "POST /api/books", "Create a new book",
            "PUT /api/books/{id}", "Update a book",
            "DELETE /api/books/{id}", "Delete a book"
        ));
        return ResponseEntity.ok(response);
    }
}

