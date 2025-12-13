package edu.epam.fop.restproject.service;

public interface CrudService<T, ID> {

    T get(ID id);

    T save(T person);

    T update(ID id, T person);

    void delete(ID id);

}
