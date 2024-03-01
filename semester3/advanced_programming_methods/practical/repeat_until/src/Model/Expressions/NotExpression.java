package Model.Expressions;

import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.Types.Type;
import Model.Values.BoolValue;
import Model.Values.Value;

public class NotExpression implements Expression {
    private Expression expression;

    @Override
    public String toString() {
        return "!" + expression.toString();
    }

    public NotExpression(Expression expr)
    {
        this.expression = expr;
    }

    @Override
    public Value evaluate(MyDictionary_Interface<String, Value> table, MyHeap_Interface<Value> heap) throws Exception
    {
        Value result = expression.evaluate(table,heap);
        if(((BoolValue)result).get_value()==false)
            return new BoolValue(true);
        return new BoolValue(false);
    }

    @Override
    public Type type_check(MyDictionary_Interface<String, Type> typeEnv) throws Exception {
        return expression.type_check(typeEnv);
    }
}