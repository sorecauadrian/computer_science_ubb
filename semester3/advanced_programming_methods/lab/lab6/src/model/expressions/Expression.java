package model.expressions;

import exceptions.InterpreterException;
import exceptions.TypeException;
import model.adts.MyDictionaryInterface;
import model.adts.MyHeapInterface;
import model.types.Type;
import model.values.Value;

public interface Expression
{
    Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) throws InterpreterException;
    Expression deepCopy();
    Type typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException;
}
