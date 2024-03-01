package Model.ADTs;

import java.util.Map;

public interface MyProcedureTable_Interface<T>
{
    Map<String,T> get_content();
    void put(String name,T value);
    T lookup(String name);

}
