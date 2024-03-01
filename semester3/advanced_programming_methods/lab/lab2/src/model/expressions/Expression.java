package model.expressions;

import exceptions.InterpreterException;
import model.adts.MyDictionaryInterface;
import model.values.Value;

public interface Expression
{
    Value evaluate(MyDictionaryInterface<String, Value> tbl) throws InterpreterException;
}
