package model.expressions;

import exceptions.InterpreterException;
import exceptions.TypeException;
import model.adts.MyDictionaryInterface;
import model.adts.MyHeapInterface;
import model.types.Type;
import model.values.Value;

public class VariableExpression implements Expression
{
    private final String id;

    public VariableExpression(String i) {this.id = i;}

    @Override
    public String toString() {return this.id;}

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) throws InterpreterException {return table.lookup(id);}

    @Override
    public Expression deepCopy() {return new VariableExpression(this.id);}

    @Override
    public Type typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException {return typeEnv.lookup(id);}
}
