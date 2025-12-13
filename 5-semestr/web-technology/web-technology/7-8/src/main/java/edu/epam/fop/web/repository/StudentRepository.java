package edu.epam.fop.web.repository;

import edu.epam.fop.web.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    boolean existsByEmail(String email); // Добавляем метод для проверки уникальности
}