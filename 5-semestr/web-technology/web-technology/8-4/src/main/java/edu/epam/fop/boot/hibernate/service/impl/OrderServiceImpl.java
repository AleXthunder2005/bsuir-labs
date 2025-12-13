package edu.epam.fop.boot.hibernate.service.impl;

import edu.epam.fop.boot.hibernate.model.Order;
import edu.epam.fop.boot.hibernate.model.Customer;
import edu.epam.fop.boot.hibernate.model.Product;
import edu.epam.fop.boot.hibernate.repository.OrderRepository;
import edu.epam.fop.boot.hibernate.repository.CustomerRepository;
import edu.epam.fop.boot.hibernate.repository.ProductRepository;
import edu.epam.fop.boot.hibernate.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;

    @Autowired
    public OrderServiceImpl(OrderRepository orderRepository, CustomerRepository customerRepository, ProductRepository productRepository) {
        this.orderRepository = orderRepository;
        this.customerRepository = customerRepository;
        this.productRepository = productRepository;
    }

    @Override
    public List<Order> getAll() {
        return orderRepository.findAll();
    }

    @Override
    public Order getById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found with id: " + id));
    }

    @Override
    public Order create(Order order) {
        if (order.getCustomer() != null && order.getCustomer().getId() != null) {
            Customer customer = customerRepository.findById(order.getCustomer().getId())
                    .orElseThrow(() -> new RuntimeException("Customer not found with id: " + order.getCustomer().getId()));
            order.setCustomer(customer);
        }
        
        if (order.getProducts() != null && !order.getProducts().isEmpty()) {
            List<Product> products = order.getProducts().stream()
                    .map(product -> {
                        if (product.getId() != null) {
                            return productRepository.findById(product.getId())
                                    .orElseThrow(() -> new RuntimeException("Product not found with id: " + product.getId()));
                        }
                        return product;
                    })
                    .collect(Collectors.toList());
            order.setProducts(products.stream().collect(Collectors.toSet()));
        }
        
        return orderRepository.save(order);
    }

    @Override
    public Order update(Long id, Order order) {
        Order existingOrder = getById(id);
        existingOrder.setTotalPrice(order.getTotalPrice());
        
        if (order.getCustomer() != null && order.getCustomer().getId() != null) {
            Customer customer = customerRepository.findById(order.getCustomer().getId())
                    .orElseThrow(() -> new RuntimeException("Customer not found with id: " + order.getCustomer().getId()));
            existingOrder.setCustomer(customer);
        }
        
        if (order.getProducts() != null && !order.getProducts().isEmpty()) {
            List<Product> products = order.getProducts().stream()
                    .map(product -> {
                        if (product.getId() != null) {
                            return productRepository.findById(product.getId())
                                    .orElseThrow(() -> new RuntimeException("Product not found with id: " + product.getId()));
                        }
                        return product;
                    })
                    .collect(Collectors.toList());
            existingOrder.setProducts(products.stream().collect(Collectors.toSet()));
        }
        
        return orderRepository.save(existingOrder);
    }

    @Override
    public void delete(Long id) {
        Order order = getById(id);
        orderRepository.delete(order);
    }
}

