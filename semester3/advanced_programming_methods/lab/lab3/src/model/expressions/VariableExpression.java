package model.expressions;

import exceptions.InterpreterException;
import model.adts.MyDictionaryInterface;
import model.values.Value;

public class VariableExpression implements Expression
{
    private final String id;

    public VariableExpression(String i) {this.id = i;}

    @Override
    public String toString() {return this.id;}

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table) {return table.lookup(id);}

    @Override
    public Expression deepCopy() {return new VariableExpression(this.id);}
}
