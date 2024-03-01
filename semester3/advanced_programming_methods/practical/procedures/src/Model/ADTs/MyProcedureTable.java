package Model.ADTs;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class MyProcedureTable<T> implements MyProcedureTable_Interface<T>
{

    Map<String,T> map;

    public MyProcedureTable() {
        this.map = new ConcurrentHashMap<>();
    }

    @Override
    public Map<String,T> get_content()
    {
        return this.map;
    }

    @Override
    public void put(String name, T value) {
        map.put(name,value);
    }

    @Override
    public T lookup(String name) {
        return map.get(name);
    }
}
