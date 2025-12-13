package edu.epam.fop.boot.hibernate.service.impl;

import edu.epam.fop.boot.hibernate.model.Customer;
import edu.epam.fop.boot.hibernate.repository.CustomerRepository;
import edu.epam.fop.boot.hibernate.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    private final CustomerRepository customerRepository;

    @Autowired
    public CustomerServiceImpl(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    @Override
    public List<Customer> getAll() {
        return customerRepository.findAll();
    }

    @Override
    public Customer getById(Long id) {
        return customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found with id: " + id));
    }

    @Override
    public Customer create(Customer customer) {
        return customerRepository.save(customer);
    }

    @Override
    public Customer update(Long id, Customer customer) {
        Customer existingCustomer = getById(id);
        existingCustomer.setUsername(customer.getUsername());
        return customerRepository.save(existingCustomer);
    }

    @Override
    public void delete(Long id) {
        Customer customer = getById(id);
        customerRepository.delete(customer);
    }
}

