package model.statements;

import exceptions.InterpreterException;
import model.ProgramState;

public class NOP implements Statement
{
    public NOP() {}
    @Override
    public String toString() {return "nop";}
    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {return state;}
}
