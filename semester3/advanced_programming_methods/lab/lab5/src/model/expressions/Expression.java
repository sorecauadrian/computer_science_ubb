package model.expressions;

import exceptions.InterpreterException;
import model.adts.MyDictionaryInterface;
import model.adts.MyHeapInterface;
import model.values.Value;

public interface Expression
{
    Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) throws InterpreterException;
    Expression deepCopy();
}
