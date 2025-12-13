package edu.epam.fop.boot.hibernate.service.impl;

import edu.epam.fop.boot.hibernate.model.Product;
import edu.epam.fop.boot.hibernate.model.Category;
import edu.epam.fop.boot.hibernate.repository.ProductRepository;
import edu.epam.fop.boot.hibernate.repository.CategoryRepository;
import edu.epam.fop.boot.hibernate.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;

    @Autowired
    public ProductServiceImpl(ProductRepository productRepository, CategoryRepository categoryRepository) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
    }

    @Override
    public List<Product> getAll() {
        return productRepository.findAll();
    }

    @Override
    public Product getById(Long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + id));
    }

    @Override
    public Product create(Product product) {
        if (product.getCategory() != null && product.getCategory().getId() != null) {
            Category category = categoryRepository.findById(product.getCategory().getId())
                    .orElseThrow(() -> new RuntimeException("Category not found with id: " + product.getCategory().getId()));
            product.setCategory(category);
        }
        return productRepository.save(product);
    }

    @Override
    public Product update(Long id, Product product) {
        Product existingProduct = getById(id);
        existingProduct.setName(product.getName());
        if (product.getCategory() != null && product.getCategory().getId() != null) {
            Category category = categoryRepository.findById(product.getCategory().getId())
                    .orElseThrow(() -> new RuntimeException("Category not found with id: " + product.getCategory().getId()));
            existingProduct.setCategory(category);
        }
        return productRepository.save(existingProduct);
    }

    @Override
    public void delete(Long id) {
        Product product = getById(id);
        productRepository.delete(product);
    }
}

