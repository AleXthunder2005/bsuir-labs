package edu.epam.fop.spring.boot.dbsecurity.repository;

import edu.epam.fop.spring.boot.dbsecurity.entity.Article;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ArticleRepository extends JpaRepository<Article, Long> {
    Optional<Article> findByTitle(String title);
    boolean existsByTitle(String title);
}

