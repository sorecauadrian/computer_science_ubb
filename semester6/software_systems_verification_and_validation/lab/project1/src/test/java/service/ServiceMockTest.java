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

@Tag("BigBangIntegrationTesting")
public class ServiceMockTest {

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
    void addAssignment_UnitTest() {
        StudentXMLRepository studentRepo = mock(StudentXMLRepository.class);
        TemaXMLRepository temaRepo = mock(TemaXMLRepository.class);
        NotaXMLRepository notaRepo = mock(NotaXMLRepository.class);

        when(temaRepo.save(any(Tema.class))).thenReturn(null);

        Service service = new Service(studentRepo, temaRepo, notaRepo);
        int result = service.saveTema("1", "assignment1", 10, 5);

        assertEquals(1, result, "Expected assignment to be saved successfully.");
    }

    @Test
    void addGrade_UnitTest() {
        StudentXMLRepository studentRepo = mock(StudentXMLRepository.class);
        TemaXMLRepository temaRepo = mock(TemaXMLRepository.class);
        NotaXMLRepository notaRepo = mock(NotaXMLRepository.class);

        Student student = new Student("1", "Șotropa Rafael", 937);
        Tema tema = new Tema("1", "assignment1", 10, 5);

        when(studentRepo.findOne("1")).thenReturn(student);
        when(temaRepo.findOne("1")).thenReturn(tema);
        when(notaRepo.save(any(Nota.class))).thenReturn(null);

        Service service = new Service(studentRepo, temaRepo, notaRepo);
        int result = service.saveNota("1", "1", 9.5, 10, "well done");

        assertEquals(1, result, "Expected grade to be saved successfully.");
    }

    @Test
    void bigBangIntegrationTest() {
        StudentXMLRepository studentRepo = mock(StudentXMLRepository.class);
        TemaXMLRepository temaRepo = mock(TemaXMLRepository.class);
        NotaXMLRepository notaRepo = mock(NotaXMLRepository.class);

        Student student = new Student("2", "Șorecău Adrian", 937);
        Tema tema = new Tema("2", "assignment2", 12, 7);

        when(studentRepo.save(any(Student.class))).thenReturn(null);
        when(temaRepo.save(any(Tema.class))).thenReturn(null);
        when(notaRepo.save(any(Nota.class))).thenReturn(null);

        when(studentRepo.findOne("2")).thenReturn(student);
        when(temaRepo.findOne("2")).thenReturn(tema);

        Service service = new Service(studentRepo, temaRepo, notaRepo);

        int resultStudent = service.saveStudent("2", "Șorecău Adrian", 937);
        int resultTema = service.saveTema("2", "assignment2", 12, 7);
        int resultNota = service.saveNota("2", "2", 10.0, 12, "insane!");

        assertEquals(1, resultStudent, "Expected student to be saved successfully.");
        assertEquals(1, resultTema, "Expected assignment to be saved successfully.");
        assertEquals(1, resultNota, "Expected grade to be saved successfully.");
    }
}
