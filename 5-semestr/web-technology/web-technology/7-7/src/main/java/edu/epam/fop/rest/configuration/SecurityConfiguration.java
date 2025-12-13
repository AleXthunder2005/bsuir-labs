package edu.epam.fop.rest.configuration;

// import edu.epam.fop.rest.service.CustomUserDetailsService; // Убираем импорт, если не используем
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {

    // Убрали поле и конструктор, так как userDetailsService не используется в этом классе
    // private final CustomUserDetailsService userDetailsService;

    // public SecurityConfiguration(CustomUserDetailsService userDetailsService) {
    //     this.userDetailsService = userDetailsService;
    // }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable) // Отключаем CSRF для REST API
                .authorizeHttpRequests(authz -> authz
                        .requestMatchers("/api/users").permitAll() // Регистрация доступна всем
                        .requestMatchers("/api/me").authenticated() // /me требует аутентификации
                        .requestMatchers("/api/users/**").hasRole("ADMIN") // /users/** доступно только админу
                        .anyRequest().authenticated() // Все остальные запросы требуют аутентификации
                )
                .formLogin(form -> form.disable()) // Отключаем стандартный login form
                .httpBasic(httpBasic -> httpBasic.disable()) // Отключаем basic auth (если не нужен)
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout") // Редирект после logout (необязательно для API)
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                );

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }
}