package edu.epam.fop.restproject.controller;

import edu.epam.fop.restproject.model.Person;
import edu.epam.fop.restproject.service.PersonCrudService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/people")
public class PersonController {

    private final PersonCrudService crudService;

    @Autowired
    public PersonController(PersonCrudService crudService) {
        this.crudService = crudService;
    }

    // GET /people - получить всех persons
    @GetMapping
    public ResponseEntity<Map<Long, Person>> getAll() {
        Map<Long, Person> persons = crudService.getAll();
        return ResponseEntity.ok(persons);
    }

    // GET /people/{id} - получить person по ID
    @GetMapping("/{id}")
    public ResponseEntity<Person> getById(@PathVariable Long id) {
        Person person = crudService.get(id);
        if (person == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(person);
    }

    // POST /people - создать нового person
    @PostMapping
    public ResponseEntity<Person> create(@RequestBody Person person) {
        // ID генерируется автоматически, игнорируем переданный ID
        person.setId(null);
        Person savedPerson = crudService.save(person);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedPerson);
    }

    // PUT /people/{id} - обновить существующего person
    @PutMapping("/{id}")
    public ResponseEntity<Person> update(@PathVariable Long id, @RequestBody Person person) {
        Person updatedPerson = crudService.update(id, person);
        if (updatedPerson == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(updatedPerson);
    }

    // DELETE /people/{id} - удалить person
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        Person person = crudService.get(id);
        if (person == null) {
            return ResponseEntity.notFound().build();
        }
        crudService.delete(id);
        return ResponseEntity.noContent().build();
    }
}