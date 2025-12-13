package edu.epam.fop.web.service;

import edu.epam.fop.web.dto.StudentCreateRequest;
import edu.epam.fop.web.dto.StudentDto;
import edu.epam.fop.web.dto.StudentUpdateRequest;
import edu.epam.fop.web.model.Student;
import edu.epam.fop.web.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Optional;

@Service
public class StudentService {

    private final StudentRepository studentRepository;

    @Autowired
    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    public Page<StudentDto> getStudents(int size, int page) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Student> students = studentRepository.findAll(pageable);
        return students.map(this::mapToDto);
    }

    public StudentDto getStudentById(Long id) {
        Student student = studentRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Student not found with id: " + id));
        return mapToDto(student);
    }

    public StudentDto createStudent(StudentCreateRequest request) {
        // Проверка на уникальность email (опционально, можно и в репозитории на уровне БД)
        if (studentRepository.existsByEmail(request.getEmail())) {
            throw new ResponseStatusException(HttpStatus.UNPROCESSABLE_ENTITY, "Student with email " + request.getEmail() + " already exists.");
        }
        Student student = new Student();
        student.setFirstName(request.getFirstName());
        student.setLastName(request.getLastName());
        student.setEmail(request.getEmail());
        Student savedStudent = studentRepository.save(student);
        return mapToDto(savedStudent);
    }

    public StudentDto updateStudent(Long id, StudentUpdateRequest request) {
        Student existingStudent = studentRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Student not found with id: " + id));

        // Проверка на уникальность email (опционально, если не меняется на текущий)
        if (!existingStudent.getEmail().equals(request.getEmail()) && studentRepository.existsByEmail(request.getEmail())) {
            throw new ResponseStatusException(HttpStatus.UNPROCESSABLE_ENTITY, "Student with email " + request.getEmail() + " already exists.");
        }

        existingStudent.setFirstName(request.getFirstName());
        existingStudent.setLastName(request.getLastName());
        existingStudent.setEmail(request.getEmail());
        Student updatedStudent = studentRepository.save(existingStudent);
        return mapToDto(updatedStudent);
    }

    public void deleteStudent(Long id) {
        if (!studentRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Student not found with id: " + id);
        }
        studentRepository.deleteById(id);
    }

    private StudentDto mapToDto(Student student) {
        return new StudentDto(student.getId(), student.getFirstName(), student.getLastName(), student.getEmail());
    }

    // Вспомогательный метод для проверки уникальности email
    public boolean existsByEmail(String email) {
        return studentRepository.existsByEmail(email);
    }
}