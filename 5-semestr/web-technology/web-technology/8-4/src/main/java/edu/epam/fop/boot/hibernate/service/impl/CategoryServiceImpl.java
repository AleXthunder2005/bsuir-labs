package edu.epam.fop.boot.hibernate.service.impl;

import edu.epam.fop.boot.hibernate.model.Category;
import edu.epam.fop.boot.hibernate.repository.CategoryRepository;
import edu.epam.fop.boot.hibernate.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;

    @Autowired
    public CategoryServiceImpl(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public List<Category> getAll() {
        return categoryRepository.findAll();
    }

    @Override
    public Category getById(Long id) {
        return categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + id));
    }

    @Override
    public Category create(Category category) {
        return categoryRepository.save(category);
    }

    @Override
    public Category update(Long id, Category category) {
        Category existingCategory = getById(id);
        existingCategory.setName(category.getName());
        return categoryRepository.save(existingCategory);
    }

    @Override
    public void delete(Long id) {
        Category category = getById(id);
        categoryRepository.delete(category);
    }
}

