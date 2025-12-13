package edu.epam.fop.boot.hibernate.service;

import edu.epam.fop.boot.hibernate.model.Category;
import java.util.List;

public interface CategoryService {
    List<Category> getAll();
    Category getById(Long id);
    Category create(Category category);
    Category update(Long id, Category category);
    void delete(Long id);
}

