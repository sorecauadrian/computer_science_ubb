package model.expressions;

import exceptions.InterpreterException;
import model.adts.MyDictionaryInterface;
import model.adts.MyHeapInterface;
import model.values.Value;
public class ValueExpression implements Expression
{
    private final Value value;

    public ValueExpression(Value v) {this.value = v;}

    @Override
    public String toString() {return this.value.toString();}

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) throws InterpreterException {return this.value;}

    @Override
    public Expression deepCopy() {return new ValueExpression(this.value.deepCopy());}
}
