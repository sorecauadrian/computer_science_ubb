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

        StudentXMLRepository fileRepository1 = new StudentXMLRepository(studentValidator, "studenti.xml");
        TemaXMLRepository fileRepository2 = new TemaXMLRepository(temaValidator, "teme.xml");
        NotaXMLRepository fileRepository3 = new NotaXMLRepository(notaValidator, "note.xml");

        service = new Service(fileRepository1, fileRepository2, fileRepository3);
    }

    // saveStudent tests

    @Test
    void saveStudent_PositiveNumberId_Success() {
        int result = service.saveStudent("1", "Șotropa Rafael", 937);
        boolean studentSaved = result == 0;
        assertTrue(studentSaved, "Expected the student to be saved successfully.");
    }

    @Test
    void saveStudent_NegativeNumberId_Fail() {
        int result = service.saveStudent("-1", "Șotropa Rafael", 937);
        boolean studentSaved = result == 0;
        assertFalse(studentSaved, "Expected an exception when id is negative.");
    }

    @Test
    void saveStudent_EmptyId_Fail() {
        int result = service.saveStudent("", "Șotropa Rafael", 937);
        boolean studentSaved = result == 0;
        assertFalse(studentSaved, "Expected an exception when id is empty.");
    }

    @Test
    void saveStudent_StartingWithZeroId_Fail() {
        int result = service.saveStudent("01", "Șotropa Rafael", 937);
        boolean studentSaved = result == 0;
        assertFalse(studentSaved, "Expected an exception when id starts with 0.");
    }

    @Test
    void saveStudent_NonNumbersId_Fail() {
        int result = service.saveStudent("a", "Șotropa Rafael", 937);
        boolean studentSaved = result == 0;
        assertFalse(studentSaved, "Expected an exception when id contains non-numbers.");
    }

    @Test
    void saveStudent_EmptyName_Fail() {
        int result = service.saveStudent("1", "", 937);
        boolean studentSaved = result == 0;
        assertFalse(studentSaved, "Expected an exception when name is empty.");
    }

    @Test
    void saveStudent_NonEmptyName_Success() {
        int result = service.saveStudent("1", "Șotropa Rafael", 937);
        boolean studentSaved = result == 0;
        assertTrue(studentSaved, "Expected the student to be saved successfully.");
    }

    @Test
    void saveStudent_NegativeGroup_Fail() {
        int result = service.saveStudent("1", "Șotropa Rafael", -937);
        boolean studentSaved = result == 0;
        assertFalse(studentSaved, "Expected an exception when group is negative.");
    }

    @Test
    void saveStudent_PositiveGroup_Success() {
        int result = service.saveStudent("1", "Șotropa Rafael", 937);
        boolean studentSaved = result == 0;
        assertTrue(studentSaved, "Expected the student to be saved successfully.");
    }

    // saveAssignment tests

    @Test
    public void saveAssignment_NullId_Fail() {
        int result = service.saveTema(null, "assignment1", 10, 5);
        boolean assignmentSaved = result == 0;
        assertFalse(assignmentSaved, "Expected an exception when id is null.");
    }

    @Test
    public void saveAssignment_EmptyId_Fail() {
        int result = service.saveTema("", "assignment1", 10, 5);
        boolean assignmentSaved = result == 0;
        assertFalse(assignmentSaved, "Expected an exception when id is empty.");
    }

    @Test
    public void saveAssignment_NullDescription_Fail() {
        int result = service.saveTema("1", null, 10, 5);
        boolean assignmentSaved = result == 0;
        assertFalse(assignmentSaved, "Expected an exception when description is null.");
    }

    @Test
    public void saveAssignment_EmptyDescription_Fail() {
        int result = service.saveTema("1", "", 10, 5);
        boolean assignmentSaved = result == 0;
        assertFalse(assignmentSaved, "Expected an exception when description is empty.");
    }

    @Test
    public void saveAssignment_DeadlineLessThanOne_Fail() {
        int result = service.saveTema("1", "assignment1", 0, 5);
        boolean assignmentSaved = result == 0;
        assertFalse(assignmentSaved, "Expected an exception when deadline is less than 1.");
    }

    @Test
    public void saveAssignment_DeadlineGreaterThanFourteen_Fail() {
        int result = service.saveTema("1", "assignment1", 15, 5);
        boolean assignmentSaved = result == 0;
        assertFalse(assignmentSaved, "Expected an exception when deadline is greater than 14.");
    }

    @Test
    public void saveAssignment_StartlineGreaterThanDeadline_Fail() {
        int result = service.saveTema("1", "assignment1", 5, 10);
        boolean assignmentSaved = result == 0;
        assertFalse(assignmentSaved, "Expected an exception when startline is greater than deadline.");
    }

    @Test
    public void saveAssignment_StartlineLessThanOne_Fail() {
        int result = service.saveTema("1", "assignment1", 10, 0);
        boolean assignmentSaved = result == 0;
        assertFalse(assignmentSaved, "Expected an exception when startline is less than 1.");
    }

    @Test
    public void saveAssignment_StartlineGreaterThanFourteen_Fail() {
        int result = service.saveTema("1", "assignment1", 10, 15);
        boolean assignmentSaved = result == 0;
        assertFalse(assignmentSaved, "Expected an exception when startline is greater than 14.");
    }

    @Test
    public void saveAssignment_ValidAssignment_Success() {
        int result = service.saveTema("1", "assignment1", 10, 5);
        boolean assignmentSaved = result == 0;
        assertTrue(assignmentSaved, "Expected the assignment to be saved successfully.");
    }
}
