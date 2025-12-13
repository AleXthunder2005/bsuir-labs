package edu.epam.fop.rest.controller;

import edu.epam.fop.rest.model.User;
import edu.epam.fop.rest.repository.RoleRepository;
import edu.epam.fop.rest.repository.UserRepository;
import edu.epam.fop.rest.service.CustomUserDetailsService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.Optional;

@RestController
@RequestMapping("/api") // Добавим префикс для API
public class UserController {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final CustomUserDetailsService userDetailsService;

    public UserController(UserRepository userRepository, RoleRepository roleRepository,
                          PasswordEncoder passwordEncoder, CustomUserDetailsService userDetailsService) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
        this.userDetailsService = userDetailsService;
    }

    // public endpoint - Регистрация
    @PostMapping("/users")
    public ResponseEntity<?> createUser(@RequestBody User newUser) {
        if (userRepository.findByUsername(newUser.getUsername()).isPresent()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Username already exists");
        }

        newUser.setPassword(passwordEncoder.encode(newUser.getPassword()));
        // Присваиваем роль USER по умолчанию
        edu.epam.fop.rest.model.Role userRole = roleRepository.findByName("USER");
        if (userRole == null) {
            // Если роли нет, создаём её (можно сделать при старте приложения)
            userRole = new edu.epam.fop.rest.model.Role("USER");
            userRole = roleRepository.save(userRole);
        }
        newUser.setRoles(new HashSet<>());
        newUser.getRoles().add(userRole);

        User savedUser = userRepository.save(newUser);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedUser);
    }

    // private endpoint - Получить текущего пользователя
    @GetMapping("/me")
    public ResponseEntity<User> getUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found")); // В реальности лучше использовать более специфичный Exception

        // Не возвращаем пароль
        User responseUser = new User();
        responseUser.setId(user.getId());
        responseUser.setUsername(user.getUsername());
        responseUser.setRoles(user.getRoles());
        return ResponseEntity.ok(responseUser);
    }

    // private endpoint - Обновить текущего пользователя
    @PutMapping("/me")
    public ResponseEntity<User> updateUser(@RequestBody User updatedUser) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        Optional<User> existingUserOpt = userRepository.findByUsername(username);

        if (existingUserOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        User existingUser = existingUserOpt.get();
        // Позволим обновлять только имя пользователя
        existingUser.setUsername(updatedUser.getUsername());

        User savedUser = userRepository.save(existingUser);
        return ResponseEntity.ok(savedUser);
    }

    // admin endpoint - Обновить роли пользователя (пример)
    @PutMapping("/users/{id}/roles")
    public ResponseEntity<User> updateUserRoles(@PathVariable Long id, @RequestBody java.util.Set<edu.epam.fop.rest.model.Role> newRoles) {
        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        User user = userOpt.get();
        // В реальности тут нужно проверить, что роли существуют
        user.setRoles(newRoles);
        User savedUser = userRepository.save(user);
        return ResponseEntity.ok(savedUser);
    }
}