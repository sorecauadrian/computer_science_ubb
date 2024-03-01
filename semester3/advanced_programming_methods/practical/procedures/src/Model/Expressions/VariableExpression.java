package Model.Expressions;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.Types.Type;
import Model.Values.Value;

public class VariableExpression implements Expression
{
    private String id;

    public VariableExpression(String id)
    {
        this.id=id;
    }

    @Override
    public Value evaluate(MyDictionary_Interface<String, Value> table, MyHeap_Interface<Value> heap) throws Exception
    {
        return table.lookup(id);
    }

    @Override
    public Type type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        return type_environment.lookup(id);
    }

    public String toString()
    {
        return this.id;
    }
}
