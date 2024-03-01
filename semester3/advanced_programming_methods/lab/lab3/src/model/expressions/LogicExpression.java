package model.expressions;

import exceptions.InterpreterException;
import model.adts.MyDictionaryInterface;
import model.types.BoolType;
import model.values.BoolValue;
import model.values.Value;

import java.util.Objects;

public class LogicExpression implements Expression
{
    private final Expression expression1;
    private final Expression expression2;
    private int operation;

    public LogicExpression(String op, Expression e1, Expression e2)
    {
        this.expression1 = e1;
        this.expression2 = e2;
        if (Objects.equals(op, "and"))
            this.operation = 1;
        else if (Objects.equals(op, "or"))
            this.operation = 2;
    }

    @Override
    public String toString()
    {
        return switch (this.operation)
        {
            case 1 -> this.expression1.toString() + "&" + this.expression2.toString();
            case 2 -> this.expression1.toString() + "|" + this.expression2.toString();
            default -> "";
        };
    }

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table) throws InterpreterException
    {
        Value v1, v2;
        v1 = this.expression1.evaluate(table);
        if (v1.getType().equals(new BoolType()))
        {
            v2 = this.expression2.evaluate(table);
            if (v2.getType().equals(new BoolType()))
            {
                BoolValue b1, b2;
                b1 = (BoolValue) v1;
                b2 = (BoolValue) v2;
                boolean bool1 = b1.getValue();
                boolean bool2 = b2.getValue();
                return switch (this.operation)
                {
                    case 1 -> new BoolValue(bool1 & bool2);
                    case 2 -> new BoolValue(bool1 | bool2);
                    default -> throw new InterpreterException("Invalid operation");
                };
            }
            else throw new InterpreterException("second operand is not boolean");
        }
        else throw new InterpreterException("first operand is not boolean");
    }

    @Override
    public Expression deepCopy()
    {
        if (this.operation == 1)
            return new LogicExpression("and", this.expression1.deepCopy(), this.expression2.deepCopy());
        else
            return new LogicExpression("or", this.expression1.deepCopy(), this.expression2.deepCopy());
    }
}
