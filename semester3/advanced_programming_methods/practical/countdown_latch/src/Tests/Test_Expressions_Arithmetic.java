package Tests;

import Exceptions.*;
import Model.ADTs.*;
import Model.Expressions.ArithmeticExpression;
import Model.Expressions.ValueExpression;
import Model.Expressions.Expression;
import Model.Values.Value;
import Model.Values.IntValue;

public class Test_Expressions_Arithmetic
{
    public Test_Expressions_Arithmetic(){};

    public void test()
    {
        MyDictionary<String,Value> symbol_table=new MyDictionary<String, Value>();
        MyHeap_Interface<Value> heap=new MyHeap<>();
        Expression expression=new ArithmeticExpression("+",new ValueExpression(new IntValue(3)), new ValueExpression(new IntValue(2)));

        try{

            Value value=expression.evaluate(symbol_table,heap);
            String result="5";
            assert result.equals(value.toString());
            System.out.println("Test Passed!\n");

        } catch (Exception exception)
        {
            assert false;
        }

    }

}
