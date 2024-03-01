package model.expressions;

import exceptions.InterpreterException;
import exceptions.TypeException;
import model.adts.MyDictionaryInterface;
import model.adts.MyHeapInterface;
import model.types.IntType;
import model.types.Type;
import model.values.BoolValue;
import model.values.IntValue;
import model.values.Value;

public class RelationalExpression implements Expression
{
    private final String operation;
    private final Expression expression1;
    private final Expression expression2;

    public RelationalExpression(String op, Expression exp1, Expression exp2)
    {
        this.operation = op;
        this.expression1 = exp1;
        this.expression2 = exp2;
    }

    @Override
    public String toString() {return this.expression1.toString() + " " + this.operation + " " + this.expression2.toString();}

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) throws InterpreterException
    {
        Value value1 = this.expression1.evaluate(table, heap);
        if (value1.getType().equals(new IntType()))
        {
            Value value2 = this.expression2.evaluate(table, heap);
            if (value2.getType().equals(new IntType()))
            {
                IntValue intValue1 = (IntValue) value1;
                IntValue intValue2 = (IntValue) value2;
                int integerValue1 = intValue1.getValue();
                int integerValue2 = intValue2.getValue();
                return switch (operation)
                {
                    case "<" -> new BoolValue(integerValue1 < integerValue2);
                    case "<=" -> new BoolValue(integerValue1 <= integerValue2);
                    case ">" -> new BoolValue(integerValue1 > integerValue2);
                    case ">=" -> new BoolValue(integerValue1 >= integerValue2);
                    case "==" -> new BoolValue(integerValue1 == integerValue2);
                    case "!=" -> new BoolValue(integerValue1 != integerValue2);
                    default -> throw new InterpreterException("invalid operation");
                };
            }
            else throw new InterpreterException("expression 2 not of integer type");
        }
        else throw new InterpreterException("expression 1 not of integer type");
    }

    @Override
    public Expression deepCopy() {return new RelationalExpression(this.operation, this.expression1.deepCopy(), this.expression2.deepCopy());}

    @Override
    public Type typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException
    {
        Type type1 = this.expression1.typecheck(typeEnv);
        Type type2 = this.expression2.typecheck(typeEnv);
        if (type1.equals(new IntType()))
            if (type2.equals(new IntType()))
                return new IntType();
            else
                throw new InterpreterException("second operand is not an integer");
        else
            throw new InterpreterException("first operand is not an integer");
    }
}
