package edu.epam.fop.web.repository;

import edu.epam.fop.web.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {
    // JpaRepository предоставляет CRUD методы автоматически
}