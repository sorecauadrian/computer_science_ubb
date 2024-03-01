package repository;

import exceptions.InterpreterException;
import model.ProgramState;

public interface RepositoryInterface
{
    ProgramState getCurrentProgram();
    void addState(ProgramState state);
    void logPrgStateExec(ProgramState state) throws InterpreterException;
}
