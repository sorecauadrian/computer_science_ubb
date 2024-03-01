package Model.Expressions;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.Types.*;
import Model.Values.*;


public class LogicExpression implements Expression
{

    private Expression expression1,expression2;
    private String operand;



    public LogicExpression(Expression expression1,Expression expression2,String operand)
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

        if(value1.get_type().equals(new BoolType()))
        {
            value2=expression2.evaluate(table,heap);

            if(value2.get_type().equals(new BoolType()))
            {
                BoolValue bool1=(BoolValue)value1;
                BoolValue bool2=(BoolValue)value2;

                boolean bool_value1=bool1.get_value();
                boolean bool_value2=bool2.get_value();


                if(operand.equals("and"))
                {
                    return new BoolValue(bool_value1 && bool_value2);
                }
                else if(operand.equals("or"))
                {
                    return new BoolValue(bool_value1 || bool_value2);
                }
                else
                {
                    throw new Exception("Invalid operand!");
                }

            }
            else
            {
                throw new Exception("Second operand is not a bool!");
            }
        }
        else
        {
            throw new Exception(("First operand is not a bool!"));
        }

    }

    @Override
    public Type type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception
    {
        Type type1=expression1.type_check(type_environment);
        Type type2=expression2.type_check(type_environment);

        if(type1.equals(new BoolType()))
        {
            if(type2.equals(new BoolType()))
            {
                return new BoolType();
            }
            else
            {
                throw new MyException("Second operand is not a bool!");
            }
        }
        else
        {
            throw new MyException(("First operand is not a bool!"));
        }

    }

    public String to_string()
    {
        return this.expression1.toString() + " " + this.operand + " " + this.expression2.toString();
    }



}
