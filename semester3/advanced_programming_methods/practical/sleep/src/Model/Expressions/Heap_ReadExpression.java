package Model.Expressions;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.Types.ReferenceType;
import Model.Types.Type;
import Model.Values.ReferenceValue;
import Model.Values.Value;

public class Heap_ReadExpression implements Expression
{

    private Expression expression;

    public Heap_ReadExpression(Expression expression)
    {
        this.expression = expression;
    }


    @Override
    public Value evaluate(MyDictionary_Interface<String, Value> table, MyHeap_Interface<Value> heap) throws Exception
    {
       Value evaluation_value=this.expression.evaluate(table,heap);

       if(evaluation_value instanceof ReferenceValue)
       {

           int address=((ReferenceValue) evaluation_value).get_address();
           Value heap_value=heap.get(address);

           if(heap_value!=null)
           {
               return heap_value;
           }
           else
           {
               throw new MyException("No value found at this address!");
           }
       }
       else
       {
           throw new MyException("Value is not a Reference Value type!");
       }
    }

    @Override
    public Type type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception
    {
       Type type= expression.type_check(type_environment);
       if(type instanceof ReferenceType)
       {
           return ((ReferenceType) type).get_inner();
       }
       else
       {
           throw new MyException("The Heap_Read argument is not a Reference Type!");
       }
    }


    public String toString()
    {
        return "rh("+ expression.toString() + ")";
    }

}
