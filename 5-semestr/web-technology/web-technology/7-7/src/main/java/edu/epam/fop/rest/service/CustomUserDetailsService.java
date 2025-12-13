package edu.epam.fop.rest.service;

import edu.epam.fop.rest.model.User;
import edu.epam.fop.rest.repository.UserRepository;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.stream.Collectors;

@Service // Это аннотация, которая говорит Spring создать бин этого класса
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));

        // Важно: передаём GrantedAuthority, а не Role напрямую
        return new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPassword(), // Это уже зашифрованный пароль из БД
                mapRolesToAuthorities(user.getRoles())
        );
    }

    private Collection<? extends GrantedAuthority> mapRolesToAuthorities(java.util.Set<edu.epam.fop.rest.model.Role> roles) {
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.getName()))
                .collect(Collectors.toList());
    }
}