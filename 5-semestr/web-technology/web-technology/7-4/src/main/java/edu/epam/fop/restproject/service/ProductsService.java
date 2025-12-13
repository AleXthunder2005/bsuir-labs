package edu.epam.fop.restproject.service;

import edu.epam.fop.restproject.exception.ProductNotFoundException;
import edu.epam.fop.restproject.model.Product;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class ProductsService {

    private final Map<Long, Product> resourceRepository = new ConcurrentHashMap<>();

    {
        // test data initialization
        resourceRepository.put(1001L, new Product(1001L, "Laptop", "High-performance laptop with SSD storage", BigDecimal.valueOf(1200)));
        resourceRepository.put(1002L, new Product(1002L, "T-shirt", "Comfortable cotton T-shirt in multiple colors", BigDecimal.valueOf(12)));
    }

    public Product getProductsById(long id) {
        Product product = resourceRepository.get(id);
        if (product == null) {
            throw new ProductNotFoundException(id);
        }
        return product;
    }
}