package Model.ADTs;

import java.util.HashMap;
import java.util.Map;

public class MyLatchTable<Key,Value> implements MyLatchTable_Interface<Key,Value>
{
    private HashMap<Key,Value> latch_table;
    private int address = 1;


    public MyLatchTable(HashMap<Key, Value> latch_table)
    {
        this.latch_table = latch_table;
    }

    public MyLatchTable() {
        this.latch_table=new HashMap<Key,Value>();
    }

    @Override
    public synchronized void put(Key key, Value value)
    {
        this.latch_table.put(key,value);

    }

    @Override
    public Map<Key,Value> get_latch_table()
    {
        return this.latch_table;
    }

    @Override
    public void set_latch_table(Map<Key,Value> latch_table)
    {
        this.latch_table= (HashMap<Key, Value>) latch_table;
    }

    @Override
    public boolean is_defined(Key key)
    {
        return latch_table.containsKey(key);
    }

    @Override
    public synchronized int get_free_address()
    {
        this.address++;
        return address-1;
    }

    public Map<Key, Value> get_content()
    {
        return latch_table;
    }
}
