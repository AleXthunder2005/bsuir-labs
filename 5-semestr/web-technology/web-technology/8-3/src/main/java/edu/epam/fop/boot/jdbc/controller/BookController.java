package edu.epam.fop.boot.jdbc.controller;

import edu.epam.fop.boot.jdbc.model.Book;
import edu.epam.fop.boot.jdbc.repository.BookRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/books")
public class BookController {

    private final BookRepository bookRepository;

    public BookController(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @GetMapping
    public ResponseEntity<List<Book>> getAllBooks() {
        List<Book> books = bookRepository.findAll();
        return ResponseEntity.ok(books);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable Integer id) {
        return bookRepository.findById(id)
                .map(book -> ResponseEntity.ok(book))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Book> createBook(@RequestBody Book book) {
        Book createdBook = bookRepository.create(book);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdBook);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Book> updateBook(@PathVariable Integer id, @RequestBody Book book) {
        if (bookRepository.findById(id).isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        book.setId(id);
        Book updatedBook = bookRepository.update(book);
        return ResponseEntity.ok(updatedBook);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Integer id) {
        if (bookRepository.findById(id).isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        bookRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}

