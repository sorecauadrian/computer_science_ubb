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

@Tag("WhiteBoxTesting")
class ServiceTest {

    private Service service;

    @BeforeEach
    void setUp() {
        Validator<Student> studentValidator = new StudentValidator();
        Validator<Tema> temaValidator = new TemaValidator();
        Validator<Nota> notaValidator = new NotaValidator();

        StudentXMLRepository studentRepo = new StudentXMLRepository(studentValidator, "studenti_test.xml");
        TemaXMLRepository temaRepo = new TemaXMLRepository(temaValidator, "teme_test.xml");
        NotaXMLRepository notaRepo = new NotaXMLRepository(notaValidator, "note_test.xml");

        service = new Service(studentRepo, temaRepo, notaRepo);
    }

    // saveStudent tests

    @Test
    void saveStudent_PositiveNumberId_Success() {
        int result = service.saveStudent("1", "Șotropa Rafael", 937);
        assertEquals(0, result, "Expected the student to be saved successfully.");
    }

    @Test
    void saveStudent_NegativeNumberId_Fail() {
        int result = service.saveStudent("-1", "Șotropa Rafael", 937);
        assertEquals(1, result, "Expected failure when ID is negative.");
    }

    @Test
    void saveStudent_EmptyId_Fail() {
        int result = service.saveStudent("", "Șotropa Rafael", 937);
        assertEquals(1, result, "Expected failure when ID is empty.");
    }

    @Test
    void saveStudent_StartingWithZeroId_Fail() {
        int result = service.saveStudent("01", "Șotropa Rafael", 937);
        assertEquals(1, result, "Expected failure when ID starts with 0.");
    }

    @Test
    void saveStudent_NonNumbersId_Fail() {
        int result = service.saveStudent("a", "Șotropa Rafael", 937);
        assertEquals(1, result, "Expected failure when ID contains non-numbers.");
    }

    @Test
    void saveStudent_EmptyName_Fail() {
        int result = service.saveStudent("1", "", 937);
        assertEquals(1, result, "Expected failure when name is empty.");
    }

    @Test
    void saveStudent_NonEmptyName_Success() {
        int result = service.saveStudent("1", "Șotropa Rafael", 937);
        assertEquals(0, result, "Expected the student to be saved successfully.");
    }

    @Test
    void saveStudent_NegativeGroup_Fail() {
        int result = service.saveStudent("1", "Șotropa Rafael", -937);
        assertEquals(1, result, "Expected failure when group is negative.");
    }

    @Test
    void saveStudent_PositiveGroup_Success() {
        int result = service.saveStudent("1", "Șotropa Rafael", 937);
        assertEquals(0, result, "Expected the student to be saved successfully.");
    }

    // saveAssignment tests

    @Test
    public void saveAssignment_NullId_Fail() {
        int result = service.saveTema(null, "assignment1", 10, 5);
        assertEquals(1, result, "Expected failure when ID is null.");
    }

    @Test
    public void saveAssignment_EmptyId_Fail() {
        int result = service.saveTema("", "assignment1", 10, 5);
        assertEquals(1, result, "Expected failure when ID is empty.");
    }

    @Test
    public void saveAssignment_NullDescription_Fail() {
        int result = service.saveTema("1", null, 10, 5);
        assertEquals(1, result, "Expected failure when description is null.");
    }

    @Test
    public void saveAssignment_EmptyDescription_Fail() {
        int result = service.saveTema("1", "", 10, 5);
        assertEquals(1, result, "Expected failure when description is empty.");
    }

    @Test
    public void saveAssignment_DeadlineLessThanOne_Fail() {
        int result = service.saveTema("1", "assignment1", 0, 5);
        assertEquals(1, result, "Expected failure when deadline is less than 1.");
    }

    @Test
    public void saveAssignment_DeadlineGreaterThanFourteen_Fail() {
        int result = service.saveTema("1", "assignment1", 15, 5);
        assertEquals(1, result, "Expected failure when deadline is greater than 14.");
    }

    @Test
    public void saveAssignment_StartlineGreaterThanDeadline_Fail() {
        int result = service.saveTema("1", "assignment1", 5, 10);
        assertEquals(1, result, "Expected failure when startline is greater than deadline.");
    }

    @Test
    public void saveAssignment_StartlineLessThanOne_Fail() {
        int result = service.saveTema("1", "assignment1", 10, 0);
        assertEquals(1, result, "Expected failure when startline is less than 1.");
    }

    @Test
    public void saveAssignment_StartlineGreaterThanFourteen_Fail() {
        int result = service.saveTema("1", "assignment1", 10, 15);
        assertEquals(1, result, "Expected failure when startline is greater than 14.");
    }

    @Test
    public void saveAssignment_ValidAssignment_Success() {
        int result = service.saveTema("1", "assignment1", 10, 5);
        assertEquals(0, result, "Expected the assignment to be saved successfully.");
    }
}
