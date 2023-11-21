package model.expressions;

import exceptions.InterpreterException;
import model.adts.MyDictionaryInterface;
import model.types.IntType;
import model.values.IntValue;
import model.values.Value;

public class ArithmeticExpression implements Expression
{
    private final Expression expression1;
    private final Expression expression2;
    int operation;

    public ArithmeticExpression(char operation, Expression expression1, Expression expression2)
    {
        this.expression1 = expression1;
        this.expression2 = expression2;
        switch (operation)
        {
            case '+' -> this.operation = 1;
            case '-' -> this.operation = 2;
            case '*' -> this.operation = 3;
            case '/' -> this.operation = 4;
        }
    }

    @Override
    public String toString()
    {
        return switch (this.operation)
        {
            case 1 -> expression1.toString() + "+" + expression2.toString();
            case 2 -> expression1.toString() + "-" + expression2.toString();
            case 3 -> expression1.toString() + "*" + expression2.toString();
            case 4 -> expression1.toString() + "/" + expression2.toString();
            default -> "";
        };
    }

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table) throws InterpreterException
    {
        Value v1, v2;
        v1 = this.expression1.evaluate(table);
        if (v1.getType().equals(new IntType()))
        {
            v2 = this.expression2.evaluate(table);
            if (v2.getType().equals(new IntType()))
            {
                IntValue i1 = (IntValue) v1;
                IntValue i2 = (IntValue) v2;

                int n1, n2;
                n1 = i1.getValue();
                n2 = i2.getValue();
                return switch (this.operation)
                {
                    case 1 -> new IntValue(n1 + n2);
                    case 2 -> new IntValue(n1 - n2);
                    case 3 -> new IntValue(n1 * n2);
                    case 4 -> switch (n2)
                    {
                        case 0 -> throw new InterpreterException("division by zero");
                        default -> new IntValue(n1 / n2);
                    };
                    default -> throw new InterpreterException("invalid operation");
                };
            }
            else throw new InterpreterException("second operand is not an integer");
        }
        else throw new InterpreterException("first operand is not an integer");
    }

    @Override
    public Expression deepCopy()
    {
        if (this.operation == 1)
            return new ArithmeticExpression('+', this.expression1.deepCopy(), this.expression2.deepCopy());
        else if (this.operation == 2)
            return new ArithmeticExpression('-', this.expression1.deepCopy(), this.expression2.deepCopy());
        else if (this.operation == 3)
            return new ArithmeticExpression('*', this.expression1.deepCopy(), this.expression2.deepCopy());
        else
            return new ArithmeticExpression('/', this.expression1.deepCopy(), this.expression2.deepCopy());
    }
}
