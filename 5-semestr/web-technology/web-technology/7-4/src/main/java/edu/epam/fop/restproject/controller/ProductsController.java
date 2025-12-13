package edu.epam.fop.restproject.controller;

import edu.epam.fop.restproject.model.Product;
import edu.epam.fop.restproject.service.ProductsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ProductsController {

    private final ProductsService resourceService;

    public ProductsController(ProductsService resourceService) {
        this.resourceService = resourceService;
    }

    @GetMapping("/products/{id}")
    public Product getProductById(@PathVariable Long id) {

        return this.resourceService.getProductsById(id);

    }

}
