package model.statements;

import exceptions.InterpreterException;
import exceptions.TypeException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.types.Type;

public interface Statement
{
    ProgramState execute(ProgramState state) throws InterpreterException;
    Statement deepCopy();
    MyDictionaryInterface<String, Type> typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException;
}
