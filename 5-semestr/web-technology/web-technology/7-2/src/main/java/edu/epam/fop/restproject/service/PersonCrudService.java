package edu.epam.fop.restproject.service;

import edu.epam.fop.restproject.model.Person;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class PersonCrudService implements CrudService<Person, Long> {

    private final Map<Long, Person> persons = new HashMap<>();
    private final AtomicLong idCounter = new AtomicLong(1);

    @Override
    public Person get(Long id) {
        return persons.get(id);
    }

    @Override
    public Person save(Person person) {
        if (person.getId() == null) {
            person.setId(idCounter.getAndIncrement());
        }
        persons.put(person.getId(), person);
        return person;
    }

    @Override
    public Person update(Long id, Person person) {
        if (!persons.containsKey(id)) {
            return null; // или выбросить исключение
        }
        person.setId(id);
        persons.put(id, person);
        return person;
    }

    @Override
    public void delete(Long id) {
        persons.remove(id);
    }

    // Дополнительный метод для получения всех persons
    public Map<Long, Person> getAll() {
        return new HashMap<>(persons);
    }
}