package Model.Expressions;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.Types.Type;
import Model.Values.Value;

public class ValueExpression implements Expression
{

    private Value value;

    public ValueExpression(Value value)
    {
        this.value=value;
    }


    @Override
    public Value evaluate(MyDictionary_Interface<String, Value> table, MyHeap_Interface<Value> heap) throws Exception
    {
        return this.value;
    }

    @Override
    public Type type_check(MyDictionary_Interface<String, Type> type_environment) throws MyException
    {
        return value.get_type();
    }

    public String toString()
    {
        return  this.value.toString();
    }




}
