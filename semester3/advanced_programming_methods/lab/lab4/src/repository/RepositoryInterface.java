package repository;

import exceptions.InterpreterException;
import model.ProgramState;

public interface RepositoryInterface
{
    ProgramState getCurrentProgram();
    void addState(ProgramState state);
    void logProgramStateExec(ProgramState state) throws InterpreterException;
}
