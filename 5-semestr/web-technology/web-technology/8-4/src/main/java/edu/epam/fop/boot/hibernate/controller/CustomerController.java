package edu.epam.fop.boot.hibernate.controller;

import edu.epam.fop.boot.hibernate.model.Customer;
import edu.epam.fop.boot.hibernate.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/customers")
public class CustomerController {

    private final CustomerService customerService;

    @Autowired
    public CustomerController(CustomerService customerService) {
        this.customerService = customerService;
    }

    @GetMapping
    public ResponseEntity<List<Customer>> getAll() {
        List<Customer> customers = customerService.getAll();
        return ResponseEntity.ok(customers);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Customer> getById(@PathVariable Long id) {
        Customer customer = customerService.getById(id);
        return ResponseEntity.ok(customer);
    }

    @PostMapping
    public ResponseEntity<Customer> create(@RequestBody Customer customer) {
        Customer createdCustomer = customerService.create(customer);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdCustomer);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Customer> update(@PathVariable Long id, @RequestBody Customer customer) {
        Customer updatedCustomer = customerService.update(id, customer);
        return ResponseEntity.ok(updatedCustomer);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        customerService.delete(id);
        return ResponseEntity.noContent().build();
    }
}

