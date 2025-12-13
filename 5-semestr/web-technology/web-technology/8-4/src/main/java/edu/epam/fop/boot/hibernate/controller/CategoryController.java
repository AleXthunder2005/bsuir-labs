package edu.epam.fop.boot.hibernate.controller;

import edu.epam.fop.boot.hibernate.model.Category;
import edu.epam.fop.boot.hibernate.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/categories")
public class CategoryController {

    private final CategoryService categoryService;

    @Autowired
    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping
    public ResponseEntity<List<Category>> getAll() {
        List<Category> categories = categoryService.getAll();
        return ResponseEntity.ok(categories);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Category> getById(@PathVariable Long id) {
        Category category = categoryService.getById(id);
        return ResponseEntity.ok(category);
    }

    @PostMapping
    public ResponseEntity<Category> create(@RequestBody Category category) {
        Category createdCategory = categoryService.create(category);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdCategory);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Category> update(@PathVariable Long id, @RequestBody Category category) {
        Category updatedCategory = categoryService.update(id, category);
        return ResponseEntity.ok(updatedCategory);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        categoryService.delete(id);
        return ResponseEntity.noContent().build();
    }
}

