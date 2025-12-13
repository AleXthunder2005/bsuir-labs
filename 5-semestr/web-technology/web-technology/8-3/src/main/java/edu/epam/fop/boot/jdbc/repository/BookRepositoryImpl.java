package edu.epam.fop.boot.jdbc.repository;

import edu.epam.fop.boot.jdbc.model.Book;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import java.util.Optional;

@Repository
public class BookRepositoryImpl implements BookRepository {

    private final JdbcTemplate jdbcTemplate;

    private static final RowMapper<Book> BOOK_ROW_MAPPER = (rs, rowNum) -> {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("title"));
        book.setAuthor(rs.getString("author"));
        return book;
    };

    public BookRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Book> findAll() {
        String sql = "SELECT id, title, author FROM books";
        return jdbcTemplate.query(sql, BOOK_ROW_MAPPER);
    }

    @Override
    public Optional<Book> findById(Integer id) {
        String sql = "SELECT id, title, author FROM books WHERE id = ?";
        try {
            Book book = jdbcTemplate.queryForObject(sql, BOOK_ROW_MAPPER, id);
            return Optional.ofNullable(book);
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    @Override
    public Book create(Book book) {
        String sql = "INSERT INTO books (title, author) VALUES (?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            return ps;
        }, keyHolder);
        
        Number key = keyHolder.getKey();
        if (key != null) {
            book.setId(key.intValue());
        }
        return book;
    }

    @Override
    public Book update(Book book) {
        String sql = "UPDATE books SET title = ?, author = ? WHERE id = ?";
        jdbcTemplate.update(sql, book.getTitle(), book.getAuthor(), book.getId());
        return findById(book.getId()).orElse(book);
    }

    @Override
    public void deleteById(Integer id) {
        String sql = "DELETE FROM books WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}

