package service;

import domain.Nota;
import domain.Student;
import domain.Tema;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import repository.NotaXMLRepository;
import repository.StudentXMLRepository;
import repository.TemaXMLRepository;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@Tag("IncrementalIntegrationTesting")
public class ServiceIncrementalIntegrationTest {

    @Test
    void addStudent_UnitTest() {
        StudentXMLRepository studentRepo = mock(StudentXMLRepository.class);
        TemaXMLRepository temaRepo = mock(TemaXMLRepository.class);
        NotaXMLRepository notaRepo = mock(NotaXMLRepository.class);

        when(studentRepo.save(any(Student.class))).thenReturn(null);

        Service service = new Service(studentRepo, temaRepo, notaRepo);

        int result = service.saveStudent("1", "Șotropa Rafael", 937);

        assertEquals(1, result, "Expected student to be saved successfully.");
    }

    @Test
    void addAssignment_IntegrationTest() {
        StudentXMLRepository studentRepo = mock(StudentXMLRepository.class);
        TemaXMLRepository temaRepo = mock(TemaXMLRepository.class);
        NotaXMLRepository notaRepo = mock(NotaXMLRepository.class);

        when(studentRepo.save(any(Student.class))).thenReturn(null);

        when(temaRepo.save(any(Tema.class))).thenReturn(null);

        Service service = new Service(studentRepo, temaRepo, notaRepo);

        int resultStudent = service.saveStudent("2", "Șorecău Adrian", 937);
        int resultTema = service.saveTema("1", "Assignment1", 7, 5);

        assertEquals(1, resultStudent, "Expected student to be saved successfully.");
        assertEquals(1, resultTema, "Expected assignment to be saved successfully.");
    }

    @Test
    void addGrade_IntegrationTest() {
        StudentXMLRepository studentRepo = mock(StudentXMLRepository.class);
        TemaXMLRepository temaRepo = mock(TemaXMLRepository.class);
        NotaXMLRepository notaRepo = mock(NotaXMLRepository.class);

        when(studentRepo.save(any(Student.class))).thenReturn(null);
        when(temaRepo.save(any(Tema.class))).thenReturn(null);

        Student student = new Student("4", "Șorecău Adrian", 937);
        Tema tema = new Tema("3", "Assignment3", 10, 6);
        when(studentRepo.findOne("4")).thenReturn(student);
        when(temaRepo.findOne("3")).thenReturn(tema);

        when(notaRepo.save(any(Nota.class))).thenReturn(null);

        Service service = new Service(studentRepo, temaRepo, notaRepo);

        int resultStudent = service.saveStudent("4", "Șorecău Adrian", 937);
        int resultTema = service.saveTema("3", "Assignment3", 10, 6);
        int resultNota = service.saveNota("4", "3", 9.0, 10, "Good job!");

        assertEquals(1, resultStudent, "Expected student to be saved successfully.");
        assertEquals(1, resultTema, "Expected assignment to be saved successfully.");
        assertEquals(1, resultNota, "Expected grade to be saved successfully.");
    }
}
