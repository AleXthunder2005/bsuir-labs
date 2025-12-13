package edu.epam.fop.boot.hibernate.repository;

import edu.epam.fop.boot.hibernate.model.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {
}

