package edu.epam.fop.rest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/person")
public class PersonController {

    // In-memory storage for demonstration
    private final Map<Long, Person> personRepository = new HashMap<>();
    private long nextId = 1;

    // POST - Create new person
    @PostMapping
    public ResponseEntity<Person> createPerson(@Valid @RequestBody Person person) {
        person.setId(nextId++);
        personRepository.put(person.getId(), person);
        return ResponseEntity.status(HttpStatus.CREATED).body(person);
    }

    // PUT - Update existing person
    @PutMapping("/{id}")
    public ResponseEntity<Person> updatePerson(@PathVariable Long id, @Valid @RequestBody Person person) {
        if (!personRepository.containsKey(id)) {
            return ResponseEntity.notFound().build();
        }
        person.setId(id);
        personRepository.put(id, person);
        return ResponseEntity.ok(person);
    }

    // GET - Get person by ID
    @GetMapping("/{id}")
    public ResponseEntity<Person> getPerson(@PathVariable Long id) {
        Person person = personRepository.get(id);
        if (person == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(person);
    }

    // GET - Get all persons
    @GetMapping
    public ResponseEntity<Map<Long, Person>> getAllPersons() {
        return ResponseEntity.ok(new HashMap<>(personRepository));
    }

    // DELETE - Delete person
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePerson(@PathVariable Long id) {
        if (!personRepository.containsKey(id)) {
            return ResponseEntity.notFound().build();
        }
        personRepository.remove(id);
        return ResponseEntity.noContent().build();
    }
}