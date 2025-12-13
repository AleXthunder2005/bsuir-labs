package edu.epam.fop.spring.boot.dbsecurity.config;

import edu.epam.fop.spring.boot.dbsecurity.entity.Role;
import edu.epam.fop.spring.boot.dbsecurity.entity.User;
import edu.epam.fop.spring.boot.dbsecurity.repository.RoleRepository;
import edu.epam.fop.spring.boot.dbsecurity.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(UserRepository userRepository,
                      RoleRepository roleRepository,
                      PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) throws Exception {
        // Create roles
        Role userRole = roleRepository.findByName("USER")
                .orElseGet(() -> roleRepository.save(new Role("USER")));
        Role adminRole = roleRepository.findByName("ADMIN")
                .orElseGet(() -> roleRepository.save(new Role("ADMIN")));

        // Create regular user
        if (userRepository.findByUsername("user").isEmpty()) {
            User user = new User();
            user.setUsername("user");
            user.setPassword(passwordEncoder.encode("password"));
            user.setRoles(Set.of(userRole));
            userRepository.save(user);
        }

        // Create admin user
        if (userRepository.findByUsername("admin").isEmpty()) {
            User admin = new User();
            admin.setUsername("admin");
            admin.setPassword(passwordEncoder.encode("admin"));
            admin.setRoles(Set.of(adminRole));
            userRepository.save(admin);
        }
    }
}