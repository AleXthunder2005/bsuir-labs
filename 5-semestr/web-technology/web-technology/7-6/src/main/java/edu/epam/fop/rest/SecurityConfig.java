package edu.epam.fop.rest;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends AbstractSecurityWebApplicationInitializer {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authz -> authz
                        // Public endpoints - no authentication required
                        .antMatchers("/api/public/**").permitAll()
                        // User endpoints - accessible by USER and ADMIN roles
                        .antMatchers("/api/user/**").hasAnyRole("USER", "ADMIN")
                        // Admin endpoints - accessible only by ADMIN role
                        .antMatchers("/api/admin/**").hasRole("ADMIN")
                        // All other endpoints require authentication
                        .anyRequest().authenticated()
                )
                .httpBasic(Customizer.withDefaults()) // Enable HTTP Basic Authentication
                .csrf(csrf -> csrf.disable()); // Disable CSRF for REST API

        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        UserDetails user = User.builder()
                .username("user")
                .password(passwordEncoder().encode("password"))
                .roles("USER")
                .build();

        UserDetails admin = User.builder()
                .username("admin")
                .password(passwordEncoder().encode("admin"))
                .roles("ADMIN", "USER")
                .build();

        UserDetails viewer = User.builder()
                .username("viewer")
                .password(passwordEncoder().encode("viewer"))
                .roles("VIEWER")
                .build();

        return new InMemoryUserDetailsManager(user, admin, viewer);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}