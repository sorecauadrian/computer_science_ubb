package Model.Expressions;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.Types.Type;
import Model.Values.Value;





public interface Expression
{
    Value evaluate(MyDictionary_Interface<String,Value> table, MyHeap_Interface<Value> heap) throws Exception;
    Type type_check(MyDictionary_Interface<String,Type> type_environment) throws Exception;

}
