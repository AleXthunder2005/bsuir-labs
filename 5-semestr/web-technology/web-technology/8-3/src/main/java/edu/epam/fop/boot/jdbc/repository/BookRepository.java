package edu.epam.fop.boot.jdbc.repository;

import edu.epam.fop.boot.jdbc.model.Book;

import java.util.List;
import java.util.Optional;

public interface BookRepository {

    List<Book> findAll();

    Optional<Book> findById(Integer id);

    Book create(Book book);

    Book update(Book book);

    void deleteById(Integer id);

}
