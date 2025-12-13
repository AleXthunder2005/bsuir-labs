package edu.epam.fop.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class SecureController {

    // Public endpoint - no authentication required
    @GetMapping("/public/info")
    public Map<String, String> getPublicInfo() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "This is public information available to everyone");
        response.put("access", "PUBLIC");
        return response;
    }

    // User endpoint - requires USER or ADMIN role
    @GetMapping("/user/profile")
    public Map<String, String> getUserProfile() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "User profile information");
        response.put("access", "USER_ROLE_REQUIRED");
        response.put("data", "Sensitive user data");
        return response;
    }

    // Admin endpoint - requires ADMIN role
    @GetMapping("/admin/dashboard")
    public Map<String, String> getAdminDashboard() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "Admin dashboard");
        response.put("access", "ADMIN_ROLE_REQUIRED");
        response.put("data", "Administrative data and statistics");
        return response;
    }

    // Protected endpoint - requires any authentication
    @GetMapping("/private/data")
    public Map<String, String> getPrivateData() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "Private data - authentication required");
        response.put("access", "AUTHENTICATION_REQUIRED");
        response.put("data", "Confidential information");
        return response;
    }

    // User management endpoint
    @GetMapping("/user/list")
    public Map<String, String> getUserList() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "List of users");
        response.put("access", "USER_ROLE_REQUIRED");
        response.put("data", "User list data");
        return response;
    }

    // Admin management endpoint
    @GetMapping("/admin/users")
    public Map<String, String> getAllUsers() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "All users management");
        response.put("access", "ADMIN_ROLE_REQUIRED");
        response.put("data", "Complete user database");
        return response;
    }
}