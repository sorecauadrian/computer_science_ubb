package model.statements;

import exceptions.InterpreterException;
import model.ProgramState;

public interface Statement
{
    ProgramState execute(ProgramState state) throws InterpreterException;
    Statement deepCopy();
}
