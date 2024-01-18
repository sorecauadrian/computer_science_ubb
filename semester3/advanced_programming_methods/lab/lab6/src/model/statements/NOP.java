package model.statements;

import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.types.Type;

public class NOP implements Statement
{
    public NOP() {}
    @Override
    public String toString() {return "nop";}
    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {return null;}
    @Override
    public Statement deepCopy() {return new NOP();}
    @Override
    public MyDictionaryInterface<String, Type> typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException {return typeEnv;}
}
