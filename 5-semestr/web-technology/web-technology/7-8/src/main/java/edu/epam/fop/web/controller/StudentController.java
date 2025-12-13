package edu.epam.fop.web.controller;

import edu.epam.fop.web.dto.StudentCreateRequest;
import edu.epam.fop.web.dto.StudentDto;
import edu.epam.fop.web.dto.StudentUpdateRequest;
import edu.epam.fop.web.model.Student;
import edu.epam.fop.web.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api")
public class StudentController {

    private final StudentService studentService;

    @Autowired
    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    // GET /student
    @GetMapping("/student")
    public ResponseEntity<Page<StudentDto>> getStudents(
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "0") int page) {
        Page<StudentDto> students = studentService.getStudents(size, page);
        return ResponseEntity.ok(students);
    }

    // GET /student/{id}
    @GetMapping("/student/{id}")
    public ResponseEntity<StudentDto> getStudent(@PathVariable Long id) {
        StudentDto student = studentService.getStudentById(id);
        return ResponseEntity.ok(student);
    }

    // POST /student
    @PostMapping("/student")
    public ResponseEntity<?> createStudent(@Valid @RequestBody StudentCreateRequest request) {
        try {
            StudentDto createdStudent = studentService.createStudent(request);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdStudent);
        } catch (Exception e) {
            // В реальности лучше кидать специфичные исключения
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body("Could not create student: " + e.getMessage());
        }
    }

    // PUT /student/{id}
    @PutMapping("/student/{id}")
    public ResponseEntity<?> updateStudent(@PathVariable Long id, @Valid @RequestBody StudentUpdateRequest request) {
        try {
            StudentDto updatedStudent = studentService.updateStudent(id, request);
            return ResponseEntity.ok(updatedStudent);
        } catch (Exception e) {
            // В реальности лучше кидать специфичные исключения
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body("Could not update student: " + e.getMessage());
        }
    }

    // DELETE /student/{id}
    @DeleteMapping("/student/{id}")
    public ResponseEntity<Void> deleteStudent(@PathVariable Long id) {
        studentService.deleteStudent(id);
        return ResponseEntity.noContent().build(); // 204 No Content
    }
}