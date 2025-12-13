package edu.epam.fop.presentation.rest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import io.swagger.v3.oas.annotations.Operation;

@Controller
@RequestMapping("/api")
public class CustomViewController {

    @Operation(summary = "Get custom view data", description = "Returns custom view data using @ResponseBody annotation")
    @GetMapping("/custom-view")
    @ResponseBody
    public String getCustomView() {
        // This demonstrates using @Controller with @ResponseBody instead of @RestController
        // Useful for hybrid apps where server partially renders content for SEO or emails
        // Just like Angular and React server side rendering
        return "{\"message\": \"This is a custom view response using @Controller with @ResponseBody\"}";
    }

}

