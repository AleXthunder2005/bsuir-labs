package edu.epam.fop.spring.boot.dbsecurity.repository;

import edu.epam.fop.spring.boot.dbsecurity.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
}

