package edu.epam.fop.spring.boot.dbsecurity.controller;

import edu.epam.fop.spring.boot.dbsecurity.entity.Article;
import edu.epam.fop.spring.boot.dbsecurity.repository.ArticleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/article")
public class ArticleController {

    private final ArticleRepository articleRepository;

    public ArticleController(ArticleRepository articleRepository) {
        this.articleRepository = articleRepository;
    }

    @GetMapping("/{title}")
    public ResponseEntity<String> getArticle(@PathVariable String title) {
        Optional<Article> article = articleRepository.findByTitle(title);
        return article.map(a -> ResponseEntity.ok(a.getText()))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/{title}")
    public ResponseEntity<Void> createArticle(@PathVariable String title, @RequestBody String text) {
        if (articleRepository.existsByTitle(title)) {
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }

        Article article = new Article(title, text);
        articleRepository.save(article);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/{title}")
    public ResponseEntity<Void> updateArticle(@PathVariable String title, @RequestBody String text) {
        Optional<Article> existingArticle = articleRepository.findByTitle(title);
        if (existingArticle.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Article article = existingArticle.get();
        article.setText(text);
        articleRepository.save(article);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{title}")
    public ResponseEntity<Void> deleteArticle(@PathVariable String title) {
        Optional<Article> article = articleRepository.findByTitle(title);
        if (article.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        articleRepository.delete(article.get());
        return ResponseEntity.ok().build();
    }
}
