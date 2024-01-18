package model.expressions;

import exceptions.InterpreterException;
import model.adts.MyDictionaryInterface;
import model.adts.MyHeapInterface;
import model.types.ReferenceType;
import model.types.Type;
import model.values.ReferenceValue;
import model.values.Value;

public class ReadHeapExpression implements Expression
{
    private final Expression expression;

    public ReadHeapExpression(Expression expression) {this.expression = expression;}

    @Override
    public String toString() {return "readHeap(" + this.expression.toString() + ")";}

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) throws InterpreterException
    {
        Value value = this.expression.evaluate(table, heap);
        // the expression must be evaluated to ReferenceValue
        if (value instanceof ReferenceValue)
        {
            // take the address component of the ReferenceValue computed before
            int address = ((ReferenceValue) value).getAddress();
            // access the value associated to that address in the heapTable
            if (heap.exists(address))
                return heap.get(address);
            else
                throw new InterpreterException("not allocated on heap");
        }
        else
            throw new InterpreterException("expression not of reference type");
    }

    @Override
    public Expression deepCopy() {return new ReadHeapExpression(this.expression.deepCopy());}

    @Override
    public Type typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException
    {
        Type type = this.expression.typecheck(typeEnv);
        if (type instanceof ReferenceType referenceType)
            return referenceType.getInner();
        throw new InterpreterException("the readHeap argument is not of reference type");
    }
}
