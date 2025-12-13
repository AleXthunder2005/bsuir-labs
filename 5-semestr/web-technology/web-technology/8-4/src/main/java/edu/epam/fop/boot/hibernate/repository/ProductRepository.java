package edu.epam.fop.boot.hibernate.repository;

import edu.epam.fop.boot.hibernate.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
}

