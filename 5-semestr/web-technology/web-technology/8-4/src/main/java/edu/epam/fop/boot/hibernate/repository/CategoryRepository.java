package edu.epam.fop.boot.hibernate.repository;

import edu.epam.fop.boot.hibernate.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
}

