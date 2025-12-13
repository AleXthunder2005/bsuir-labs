package edu.epam.fop.boot.hibernate.service;

import edu.epam.fop.boot.hibernate.model.Order;
import java.util.List;

public interface OrderService {
    List<Order> getAll();
    Order getById(Long id);
    Order create(Order order);
    Order update(Long id, Order order);
    void delete(Long id);
}

