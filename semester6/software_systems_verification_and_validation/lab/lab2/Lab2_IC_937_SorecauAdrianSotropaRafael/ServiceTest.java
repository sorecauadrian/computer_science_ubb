package service;

import domain.Nota;
import domain.Student;
import domain.Tema;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import repository.NotaXMLRepository;
import repository.StudentXMLRepository;
import repository.TemaXMLRepository;
import validation.NotaValidator;
import validation.StudentValidator;
import validation.TemaValidator;
import validation.Validator;

import static org.junit.jupiter.api.Assertions.*;

@Tag("BlackBoxTesting")
class ServiceTest {

    private Service service;

    @BeforeEach
    void setUp() {
        Validator<Student> studentValidator = new StudentValidator();
        Validator<Tema> temaValidator = new TemaValidator();
        Validator<Nota> notaValidator = new NotaValidator();

        StudentXMLRepository fileRepository1 = new StudentXMLRepository(studentValidator, "studenti.xml");
        TemaXMLRepository fileRepository2 = new TemaXMLRepository(temaValidator, "teme.xml");
        NotaXMLRepository fileRepository3 = new NotaXMLRepository(notaValidator, "note.xml");

        service = new Service(fileRepository1, fileRepository2, fileRepository3);
    }

    @Test
    void saveStudent_ValidStudent_Success() {
        int result = service.saveStudent("1", "Șotropa Rafael", 937);
        boolean studentSaved = result == 0;
        assertTrue(studentSaved, "Expected the valid student to be saved successfully.");
    }

    @Test
    void saveStudent_EmptyName_Exception() {
        int result = service.saveStudent("1", "", 937);
        boolean studentSaved = result == 0;
        assertFalse(studentSaved, "Expected an exception when student name is empty.");
    }

    @Test
    void saveStudent_NegativeGroup_Exception() {
        int result = service.saveStudent("1", "Șotropa Rafael", -937);
        boolean studentSaved = result == 0;
        assertFalse(studentSaved, "Expected an exception when group number is negative.");
    }
}
