package repository;

import exceptions.InterpreterException;
import model.ProgramState;

import java.util.List;

public interface RepositoryInterface
{
    void addState(ProgramState state);
    void logProgramStateExec(ProgramState state) throws InterpreterException;

    List<ProgramState> getProgramList();

    void setProgramList(List<ProgramState> programStateList);
}
