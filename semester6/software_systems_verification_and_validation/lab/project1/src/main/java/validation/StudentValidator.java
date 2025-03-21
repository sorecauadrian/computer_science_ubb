package validation;
import domain.Student;

public class StudentValidator implements Validator<Student> {
    public void validate(Student student) throws ValidationException {
        if (student.getID().equals("") || student.getID().startsWith("0") || student.getID().startsWith("-") || !student.getID().matches("\\d+")) {
            throw new ValidationException("ID invalid! \n");
        }
        if (student.getNume().equals("")) {
            throw new ValidationException("Nume invalid! \n");
        }
        if (student.getGrupa() < 0) {
            throw new ValidationException("Grupa invalida! \n");
        }
    }
}

