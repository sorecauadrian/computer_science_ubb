package model.expressions;

import exceptions.InterpreterException;
import model.adts.MyDictionaryInterface;
import model.values.Value;
public class ValueExpression implements Expression
{
    private final Value value;

    public ValueExpression(Value v) {this.value = v;}

    @Override
    public String toString() {return this.value.toString();}

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table) {return this.value;}
}
