package Model.Expressions;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.Types.Type;
import Model.Types.IntType;
import Model.Values.Value;
import Model.Values.IntValue;



public class ArithmeticExpression implements Expression
{

    private Expression expression1,expression2;
    private String operand;

    public ArithmeticExpression(String operand,Expression expression1,Expression expression2)
    {
        this.expression1=expression1;
        this.expression2=expression2;
        this.operand=operand;
    }
    public ArithmeticExpression(Expression expression1,Expression expression2,String operand)
    {
        this.expression1=expression1;
        this.expression2=expression2;
        this.operand=operand;
    }


    @Override
    public Value evaluate(MyDictionary_Interface<String, Value> table, MyHeap_Interface<Value> heap) throws Exception
    {
        Value value1,value2;
        value1=expression1.evaluate(table,heap);

        if(value1.get_type().equals(new IntType()))
        {

            value2=expression2.evaluate(table,heap);

            if(value2.get_type().equals(new IntType()))
            {

                IntValue integer1=(IntValue) value1;
                IntValue integer2=(IntValue) value2;

                int number1=integer1.get_value();
                int number2=integer2.get_value();

                if (operand.equals("+"))
                {
                    return new IntValue(number1+number2);
                }
               else if (operand.equals("-"))
                {
                    return new IntValue(number1-number2);
                }
                else if(operand.equals("*"))
                {
                    return new IntValue(number1*number2);
                }
                else if (operand.equals("/"))
                {
                    if(number2==0)
                    {
                        throw new MyException("Division by zero!");
                    }
                    else
                        {
                            return new IntValue(number1/number2);
                        }
                }
                else
                {
                    throw new MyException("Invalid operand!");
                }


            }
            else
            {
                throw new MyException("Second operand is not an integer!");
            }


        }
        else
        {
            throw new MyException("First operand is not an integer!");
        }


    }

    @Override
    public Type type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        Type type1=expression1.type_check(type_environment);
        Type type2=expression2.type_check(type_environment);

        if(type1.equals(new IntType()))
        {
            if(type2.equals(new IntType()))
            {
                return new IntType();
            }
            else
            {
                throw new MyException("Second operand is not an integer!");
            }

        }
        else
        {
            throw new MyException("First operand is not an integer!");
        }
    }

    public String toString()
    {
        return this.expression1.toString()  + this.operand  + this.expression2.toString();
    }
}
