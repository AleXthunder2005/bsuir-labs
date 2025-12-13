package edu.epam.fop.rest;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.validation.constraints.Min;

public class Person {

    @NotNull(message = "ID cannot be null")
    @Min(value = 1, message = "ID must be greater than 0")
    private Long id;

    @NotBlank(message = "Name cannot be blank")
    @Size(min = 2, max = 50, message = "Name must be between 2 and 50 characters")
    private String name;

    // Конструкторы
    public Person() {
    }

    public Person(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    // Геттеры и сеттеры
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Person{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}