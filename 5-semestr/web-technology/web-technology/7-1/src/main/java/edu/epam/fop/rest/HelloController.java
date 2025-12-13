package edu.epam.fop.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class HelloController {

    @GetMapping("/hello")
    public String sayHello() {
        return "Hello from Spring MVC without Spring Boot!";
    }

    @GetMapping("/greeting")
    public Greeting getGreeting() {
        return new Greeting("Hello", "Welcome to Spring REST!");
    }

    // Simple POJO for JSON response
    public static class Greeting {
        private String title;
        private String message;

        public Greeting() {}

        public Greeting(String title, String message) {
            this.title = title;
            this.message = message;
        }

        // Getters and setters
        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}