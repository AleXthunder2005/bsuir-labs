package edu.epam.fop.boot.hibernate.controller;

import edu.epam.fop.boot.hibernate.model.Order;
import edu.epam.fop.boot.hibernate.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private final OrderService orderService;

    @Autowired
    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping
    public ResponseEntity<List<Order>> getAll() {
        List<Order> orders = orderService.getAll();
        return ResponseEntity.ok(orders);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Order> getById(@PathVariable Long id) {
        Order order = orderService.getById(id);
        return ResponseEntity.ok(order);
    }

    @PostMapping
    public ResponseEntity<Order> create(@RequestBody Order order) {
        Order createdOrder = orderService.create(order);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdOrder);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Order> update(@PathVariable Long id, @RequestBody Order order) {
        Order updatedOrder = orderService.update(id, order);
        return ResponseEntity.ok(updatedOrder);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        orderService.delete(id);
        return ResponseEntity.noContent().build();
    }
}

